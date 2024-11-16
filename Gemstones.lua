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
    key = "GemSlot-Empty",
    badge_colour = HEX("734226"),
    prefix_config = { key = false },
    rate = 0.0,
    atlas = "slot_atlas",
    pos = { x = 1, y = 0 },
    loc_txt = {
        name = "Gem Slot (Empty)",
        text = { "No effect" },
        label = "Gem Slot"
    },
    loc_vars = function(self, info_queue, card)
        return {}
    end
}

SMODS.Sticker{
    key = "GemSlot-Ruby",
    badge_colour = HEX("734226"),
    prefix_config = { key = false },
    rate = 0.0,
    atlas = "slot_atlas",
    pos = { x = 1, y = 0 },
    config = { x_mult = 1.2 },
    loc_txt = {
        name = "Gem Slot (Ruby)",
        text = {
            "Gives {X:mult,C:white}X#1#{} Mult",
            "when scored"
        },
        label = "Gem Slot"
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.x_mult } }
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

-- Ruby
SMODS.Consumable{
    object_type = "Consumable",
    set = "Gemstone",
    name = "gem-Ruby",
    key = "ruby",
    pos = { x = 3, y = 3 },
    cost = 3,
    atlas = "gems_atlas",
    should_apply = false,
    order = 1,
    loc_txt = {
        name = "Ruby",
        text = {
            "When attatched to",
            "a card or Joker,",
            "gives {X:mult,C:white}X#1#{} Mult",
            "when scored"
        }
    },
    config = {
        max_highlighted = 1,
        x_mult = 1.2,
    },

    loc_vars = function(self, info_queue)
        return { vars = { self.config.x_mult } }
    end,

    can_use = function(self, card)
        if #G.hand.highlighted == 1 then
            return true
        end
    end,
    
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                card:set_ruby_slot()
                return true
            end
        }))
    end,

    disovered = true,
}

function Card:calculate_ruby_slot()
    return {
        x_mult = 1.2
    }
end

function Card:set_ruby_slot()
    self.ability.gem_slot = "ruby"
end

-- CARD FUNCS
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
end