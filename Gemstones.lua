Gemstones = SMODS.current_mod

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

SMODS.Atlas{
    key = "gemstone_pack",
    path = "boosters.png",
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
    added = function(self, card) end,
    removed = function(self, card) end,
}

SMODS.Sticker{
    key = "gemslot_ruby",
    badge_colour = HEX("e3394f"),
    prefix_config = { key = false },
    rate = 0.0,
    atlas = "slot_atlas",
    pos = { x = 2, y = 0 },
    config = { x_mult = 1.2 },

    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.x_mult } }
    end,
    added = function(self, card)
        card.ability.x_mult = card.ability.x_mult + (self.config.x_mult - 1)
    end,
    removed = function(self, card)
        card.ability.x_mult = card.ability.x_mult - (self.config.x_mult - 1)
    end
}

SMODS.Sticker{
    key = "gemslot_pearl",
    badge_colour = HEX("34d2eb"),
    prefix_config = { key = false },
    rate = 0.0,
    atlas = "slot_atlas",
    pos = { x = 4, y = 0 },
    config = {},

    loc_vars = function(self, info_queue, card)
        return {}
    end,
    added = function(self, card) end,
    removed = function(self, card) end,
}

SMODS.Sticker{
    key = "gemslot_topaz",
    badge_colour = HEX("e6af19"),
    prefix_config = { key = false },
    rate = 0.0,
    atlas = "slot_atlas",
    pos = { x = 3, y = 1 },
    config = { dollars = 2 },

    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.x_mult } }
    end,
    added = function(self, card)
        card.ability.p_dollars = card.ability.p_dollars + self.config.dollars
    end,
    removed = function(self, card)
        card.ability.p_dollars = card.ability.p_dollars - self.config.dollars
    end
}

-- BOOSTER PACK
SMODS.Booster{
    name = "Gemstone Pack",
    key = "gemstone_normal_1",
    kind = "Gemstone",
    atlas = "gemstone_pack",
    group_key = "k_gems_gemstone_pack",
    pos = { x = 0, y = 3 },
	config = { extra = 3, choose = 1},
    cost = 4,
    order = 1,
    weight = 3,
    draw_hand = true, 
    unlocked = true,
    discovered = true,
    
    create_card = function(self, card)
        return create_card('Gemstone', G.pack_cards, nil, nil, true, true, nil, "gem-Ruby")
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.config.center.config.choose, card.ability.extra } }
    end
}

-- TYPE
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

-- TAROT CARDS
SMODS.Consumable{
    object_type = "Consumable",
    set = "Tarot",
    name = "gem-Enfusion",
    key = "enfusion",
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
        (get_gemslot(G.jokers.highlighted[1]) or get_gemslot(G.hand.highlighted[1])) == nil
    end,

    use = function(self, card, area, copier) use_gemstone_consumeable(self, card, area, copier) end,
}

SMODS.Consumable{
    object_type = "Consumable",
    set = "Tarot",
    name = "gem-Excavator",
    key = "excavator",
    atlas = "gems_atlas",
    pos = { x = 6, y = 2 },
    cost = 3,
    should_apply = false,
    disovered = true,
    order = 301,
    config = {},

    loc_vars = function(self, info_queue, desc_nodes)
        return {}
    end,

    can_use = function(self, card)
        if (#G.consumeables.cards < G.consumeables.config.card_limit or self.area == G.consumeables) 
        and G.GAME.last_used_gemstone then return true end 
    end,

    use = function(self, card, area, copier) 
        G.E_MANAGER:add_event(Event({
            trigger = 'after', 
            delay = 0.4, 
            func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound('timpani')
                    local new_gemstone = create_card('Gemstone', G.consumeables, nil, nil, nil, nil, G.GAME.last_used_gemstone, 'excavate')

                    new_gemstone:add_to_deck()
                    G.consumeables:emplace(new_gemstone)
                    card:juice_up(0.3, 0.5)
                end
                return true    
            end 
        }))
        delay(0.6)
    end,
}

-- GEMSTONE CARDS
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

    can_use = function(self, card) return can_use_gemstone_consumeable(self, card) end,
    use = function(self, card, area, copier) use_gemstone_consumeable(self, card, area, copier, true) end,
}

SMODS.Consumable{
    object_type = "Consumable",
    set = "Gemstone",
    name = "gem-Pearl",
    key = "pearl",
    atlas = "gems_atlas",
    pos = { x = 3, y = 2 },
    cost = 3,
    should_apply = false,
    disovered = true,
    order = 1,
    config = {
        max_highlighted = 1,
        sticker_id = "gemslot_pearl"
    },

    loc_vars = function(self, info_queue)
        info_queue[#info_queue + 1] = { key = "gemslot_pearl", set = "Other", vars = { self.config.x_mult } }
        return { vars = { self.config.max_highlighted } }
    end,

    can_use = function(self, card)
        return 
        #G.hand.highlighted == self.config.max_highlighted
        and
        get_gemslot(G.hand.highlighted[1]) ~= nil
    end,
    use = function(self, card, area, copier) use_gemstone_consumeable(self, card, area, copier, true) end,
}

SMODS.Consumable{
    object_type = "Consumable",
    set = "Gemstone",
    name = "gem-Topaz",
    key = "topaz",
    atlas = "gems_atlas",
    pos = { x = 5, y = 3 },
    cost = 3,
    should_apply = false,
    disovered = true,
    order = 1,
    config = {
        max_highlighted = 1,
        money_earned = 2,
        sticker_id = "gemslot_topaz"
    },

    loc_vars = function(self, info_queue)
        info_queue[#info_queue + 1] = { key = "gemslot_topaz", set = "Other", vars = { self.config.money_earned } }
        return { vars = { self.config.max_highlighted } }
    end,

    can_use = function(self, card) return can_use_gemstone_consumeable(self, card) end,
    use = function(self, card, area, copier) use_gemstone_consumeable(self, card, area, copier, true) end,
}

-- CARD FUNCS
function can_use_gemstone_consumeable(self, card)
    return 
    (#G.jokers.highlighted + #G.hand.highlighted) == self.config.max_highlighted
    and
    (get_gemslot(G.jokers.highlighted[1]) or get_gemslot(G.hand.highlighted[1])) ~= nil
end

function use_gemstone_consumeable(self, card, area, copier, is_gemstone)
    local joker_highlighted = G.jokers.highlighted[1]
    local hand_highlighted = G.hand.highlighted[1]

    if is_gemstone then
        G.GAME.last_used_gemstone = self.key
        sendDebugMessage("NEW LAST USED: "..G.GAME.last_used_gemstone, "Gemstones")
    end

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
            if joker_highlighted then
                set_gemslot(joker_highlighted, self.config.sticker_id)
                joker_highlighted:juice_up(0.5, 0.5)
        
            elseif hand_highlighted then
                set_gemslot(hand_highlighted, self.config.sticker_id)
                hand_highlighted:juice_up(0.5, 0.5)
            end

            card:juice_up(0.5, 0.5)
            play_sound('gold_seal', 1.2, 0.4)
            return true
        end
    }))

    delay(0.6)
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function() G.hand:unhighlight_all(); G.jokers:unhighlight_all(); return true end }))
end

function set_gemslot(self, id)
    local stickers = SMODS.Stickers

    for k, v in pairs(self.ability) do
        if string.find(k, "gemslot") then
            stickers[k]:removed(self)
            self.ability[k] = nil
        end
    end

    stickers[id]:added(self)
    self.ability[id] = true
end

function get_gemslot(card)
    if not card then return nil end
    
    for k, v in pairs(card.ability) do
        if string.find(k, "gemslot") then
            return k
        end
    end
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

-- SMODS MOD FUNCS
function Gemstones.reset_game_globals(run_start)
	G.GAME.last_used_gemstone = nil
end