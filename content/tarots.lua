-- Create Atlas
SMODS.Atlas{
    key = "tarots",
    path = "tarots.png",
    px = 71,
    py = 95
}

-- Infusion Tarot
SMODS.Consumable{
    object_type = "Consumable",
    set = "Tarot",
    name = "gem-Infusion",
    key = "infusion",
    atlas = "tarots",
    pos = { x = 0, y = 0 },
    cost = 3,
    should_apply = false,
    disovered = true,
    order = 1,
    config = {
        max_highlighted = 2,
        sticker_id = "gemslot_empty"
    },

    loc_vars = function(self, info_queue)
        info_queue[#info_queue + 1] = { key = self.config.sticker_id, set = "Other", vars = {} }
        return { vars = { self.config.max_highlighted } }
    end,

    can_use = function(self, card)
        local total = (#G.jokers.highlighted + #G.hand.highlighted)
        return total <= self.config.max_highlighted and total ~= 0
    end,

    use = function(self, card, area, copier) Gemstones.use_gemstone_consumeable(self, card, area, copier) end,
}

-- Excavator Tarot
SMODS.Consumable{
    object_type = "Consumable",
    set = "Tarot",
    name = "gem-Excavator",
    key = "excavator",
    atlas = "tarots",
    pos = { x = 1, y = 0 },
    cost = 3,
    should_apply = false,
    disovered = true,
    order = 2,
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
            delay = 0.3, 
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
        delay(0.5)
    end,
}

-- Polish Tarot
SMODS.Consumable{
    object_type = "Consumable",
    set = "Tarot",
    name = "gem-Polish",
    key = "polish",
    atlas = "tarots",
    pos = { x = 2, y = 0 },
    cost = 3,
    should_apply = false,
    disovered = true,
    order = 3,
    enhancement_gate = "m_stone",
    config = { max_highlighted = 1, create = 1 },

    loc_vars = function(self, info_queue, desc_nodes)
        return { vars = { self.config.create } }
    end,

    can_use = function(self, card)
        if #G.hand.highlighted == self.config.max_highlighted then
            if G.hand.highlighted[1].ability.effect == "Stone Card" then return true end
        end 
    end,

    use = function(self, card, area, copier) 
        local selected = G.hand.highlighted[1]
        local percent = 1.15 - (1-0.999)/(#G.hand.highlighted-0.998)*0.3

        -- replicate base game effect
        G.E_MANAGER:add_event(Event({ trigger = 'after', delay = 0.15, func = function() selected:flip(); play_sound('card1', percent); selected:juice_up(0.3, 0.3); return true end })); delay(0.2)
        G.E_MANAGER:add_event(Event({ trigger = 'after', delay = 0.15, func = function() selected:set_ability(G.P_CENTERS.c_base, nil, true) return true end }))
        G.E_MANAGER:add_event(Event({ trigger = 'after', delay = 0.15, func = function() selected:flip();play_sound('tarot2', percent, 0.6); selected:juice_up(0.3, 0.3); return true end }))
        G.E_MANAGER:add_event(Event({ trigger = 'after', delay = 0.2,  func = function() G.hand:unhighlight_all(); return true end }))

        -- add random Gemstone consumable
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.3,
            func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound("timpani")
                    local new_gemstone = create_card('Gemstone', G.consumeables, nil, nil, nil, nil, nil, 'excavate')
                    new_gemstone:add_to_deck()
                    G.consumeables:emplace(new_gemstone)
                    card:juice_up(0.3, 0.5)
                end
                return true
            end,
        }))
		delay(0.6)
    end,
}