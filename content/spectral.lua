--SMODS.Consumable{
--    set = "Spectral",
--    name = "gems-Radiance",
--    key = "radiance",
--    config = {
--        max_highlighted = 1,
--        sticker_id = "gemslot_astral"
--    },
--
--    loc_vars = function(self, info_queue)
--        return {}
--    end,
--
--    can_use = function(self, card) return can_use_gemstone_consumeable(self, card) end,
--    use = function(self, card, area, copier) use_gemstone_consumeable(self, card, area, copier, true) end,
--}

SMODS.Consumable{
    object_type = "Consumable",
    set = "Spectral",
    name = "gems-Shine",
    key = "shine",
    atlas = "tarots",
    pos = { x = 0, y = 2 },
    cost = 4,
    should_apply = false,
    discovered = true,
    order = 1,
    config = {
        max_highlighted = 3,
    },

    loc_vars = function(self, info_queue)
        return { vars = { self.config.max_highlighted } }
    end,

    can_use = function(self, card) 
        local total = #G.hand.highlighted
        return total <= self.config.max_highlighted and total ~= 0
    end,

    use = function(self, card, area, copier) 
        for i = 1, self.config.max_highlighted do
            local rand_slot = pseudorandom_element(Gemstones.pools.cards, pseudoseed('spectral_shine'))
            local _c = G.hand.highlighted[i]
            
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    Gemstones.set_gemslot(_c, rand_slot)
                    _c:juice_up(0.5, 0.5)
        
                    card:juice_up(0.5, 0.5)
                    play_sound('gold_seal', 1.2, 0.4)
                    return true
                end
            }))
        end

        delay(0.6)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function() G.hand:unhighlight_all(); G.jokers:unhighlight_all(); return true end }))
    end,
}

SMODS.Consumable{
    object_type = "Consumable",
    set = "Spectral",
    name = "gems-Greed",
    key = "greed",
    atlas = "tarots",
    pos = { x = 1, y = 2 },
    cost = 4,
    should_apply = false,
    discovered = true,
    order = 1,
    config = {
        max_highlighted = 1,
    },

    loc_vars = function(self, info_queue)
        return { vars = { self.config.max_highlighted } }
    end,

    can_use = function(self, card) 
        local total = #G.jokers.highlighted
        return total <= self.config.max_highlighted and total ~= 0
    end,

    use = function(self, card, area, copier) 
        for i = 1, self.config.max_highlighted do
            local rand_slot = pseudorandom_element(Gemstones.pools.jokers, pseudoseed('spectral_shine'))
            local _c = G.jokers.highlighted[i]
            
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    Gemstones.set_gemslot(_c, rand_slot)
                    _c:juice_up(0.5, 0.5)
        
                    card:juice_up(0.5, 0.5)
                    play_sound('gold_seal', 1.2, 0.4)
                    return true
                end
            }))
        end

        delay(0.6)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function() G.hand:unhighlight_all(); G.jokers:unhighlight_all(); return true end }))
    end,
}