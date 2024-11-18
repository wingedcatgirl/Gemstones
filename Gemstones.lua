-- ATLAS
SMODS.Atlas{
    key = "gems_atlas",
    path = "Tarots.png",
    px = 71,
    py = 95
}:register()

SMODS.Atlas{
    key = "slot_atlas",
    path = "stickers.png",
    px = 71,
    py = 95
}:register()

SMODS.Atlas{
    key = "empty_joker",
    path = "empty_joker.png",
    px = 71,
    py = 95
}:register()

-- GEM SLOTS
SMODS.Sticker{
    key = "gemslot_empty",
    badge_colour = HEX("734226"),
    prefix_config = { key = false },
    rate = 0.0,
    atlas = "slot_atlas",
    pos = { x = 1, y = 0 },
    config = {},

    loc_vars = function(self, info_queue, card)
        return {}
    end,
}

SMODS.Sticker{
    key = "gemslot_ruby",
    badge_colour = HEX("e3394f"),
    prefix_config = { key = false },
    rate = 0.0,
    atlas = "slot_atlas",
    pos = { x = 1, y = 0 },
    config = { x_mult = 1.2 },

    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.x_mult } }
    end,
    calculate = function(self, card, context)
        if context.scoring_hand or card.area == G.jokers then
            return {
                x_mult = self.config.x_mult,
                card = card
            }
        end
    end
}

-- CONSUMABLES
SMODS.ConsumableType{
	key = "Gemstone",
    primary_colour = HEX("d1303e"),
    secondary_colour = HEX("d1303e"),
    collection_rows = { 6, 6 },
    shop_rate = 0.2,
    loc_txt = {
        collection = "Gemstone Cards",
        name = "Gemstone",
        label = "Gemstone",
        undiscovered = {
            name = "Undiscovered Gemstone",
            text = { "Apply this gem", "to a card to", "discover its ability!" },
        }
    },
    default = "gem-Ruby",
    can_stack = true,
    can_divide = true
}   

SMODS.UndiscoveredSprite{
    key = 'Gemstone',
    atlas = 'gems_atlas',
    pos = {x = 5, y = 2},
}

-- Empty Slot
SMODS.Consumable{
    object_type = "Consumable",
    set = "Tarot",
    name = "gem-Create",
    key = "create_empty",
    atlas = "gems_atlas",
    pos = { x = 6, y = 2 },
    cost = 3,
    should_apply = false,
    disovered = true,
    order = 300,
    config = {
        max_highlighted = 1,
        sticker_id = "gemslot_empty"
    },

    loc_vars = function(self, info_queue)
        info_queue[#info_queue + 1] = { key = "gemslot_empty", set = "Other", vars = {} }
        return { vars = { self.config.max_highlighted } }
    end,

    can_use = function(self, card)
        return 
        (#G.jokers.highlighted + #G.hand.highlighted) == self.config.max_highlighted
        and
        (get_gemstone(G.jokers.highlighted[1]) or get_gemstone(G.hand.highlighted[1])) == nil
    end,

    use = function(self, card, area, copier) use_gemstone_consumeable(self, card, area, copier) end,
}

-- Ruby
SMODS.Consumable{
    object_type = "Consumable",
    set = "Gemstone",
    name = "gem-Ruby",
    key = "ruby",
    atlas = "gems_atlas",
    pos = { x = 3, y = 3 },
    cost = 3,
    should_apply = false,
    disovered = true,
    order = 1,
    config = {
        max_highlighted = 1,
        x_mult = 1.2,
        sticker_id = "gemslot_ruby"
    },

    loc_vars = function(self, info_queue)
        info_queue[#info_queue + 1] = { key = "gemslot_ruby", set = "Other", vars = { self.config.x_mult } }
        return { vars = { self.config.max_highlighted } }
    end,

    can_use = function(self, card)
        return 
        (#G.jokers.highlighted + #G.hand.highlighted) == self.config.max_highlighted
        and
        (get_gemstone(G.jokers.highlighted[1]) or get_gemstone(G.hand.highlighted[1])) ~= nil
    end,
    
    use = function(self, card, area, copier) use_gemstone_consumeable(self, card, area, copier) end,
}

-- CARD FUNCS
function use_gemstone_consumeable(self, card, area, copier)
    if area then
        area:remove_from_highlighted(card)
    end

    if G.jokers.highlighted[1] then
        apply_gemslot(G.jokers.highlighted[1], self.config.sticker_id)

    elseif G.hand.highlighted[1] then
        apply_gemslot(G.hand.highlighted[1], self.config.sticker_id)
    end
end

function get_gemstone(card)
    if not card then return nil end
    
    for k, v in pairs(card.ability) do
        if string.find(k, "gemslot") then
            return k
        end
    end
end

function apply_gemslot(card, id)
    for k, v in pairs(card.ability) do
        if string.find(k, "gemslot") then
            card.ability[k] = nil
        end
    end

    card.ability[id] = true
end

local ec = eval_card
function eval_card(card, context)
	local ret = ec(card, context)
    
	if card.area == G.hand or card.area == G.play or card.area == G.discard or card.area == G.deck then
		for k, v in pairs(SMODS.Stickers) do
			if card.ability[k] and v.calculate and type(v.calculate) == "function" then
				context.from_playing_card = true
				context.ret = ret
				v:calculate(card, context)
			end
		end
	end

	return ret
end