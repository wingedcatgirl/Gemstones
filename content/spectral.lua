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
        info_queue[#info_queue + 1] = { key = "gemslot_diamond", set = "Other", vars = { SMODS.Stickers["gemslot_diamond"].config.retriggers } }
        info_queue[#info_queue + 1] = { key = "gemslot_turquoise", set = "Other", vars = { SMODS.Stickers["gemslot_turquoise"].config.planets_amount } }
        info_queue[#info_queue + 1] = { key = "gemslot_emerald", set = "Other", vars = { G.GAME.probabilities.normal or 1, SMODS.Stickers["gemslot_emerald"].config.odds } }
        info_queue[#info_queue + 1] = { key = "gemslot_jade", set = "Other", vars = {} }
        info_queue[#info_queue + 1] = { key = "gemslot_amber", set = "Other", vars = { G.GAME.probabilities.normal or 1, SMODS.Stickers["gemslot_amber"].config.level_up_odds } }
        return { vars = { self.config.max_highlighted } }
    end,

    can_use = function(self, card) 
        local total = #G.hand.highlighted
        return total <= self.config.max_highlighted and total ~= 0
    end,

    use = function(self, card, area, copier) 
        for i = 1, self.config.max_highlighted do
            local options = { "diamond", "turquoise", "emerald", "jade", "amber" }
            local rand_slot = "gemslot_"..pseudorandom_element(options, pseudoseed('spectral_shine'))
            local _c = G.hand.highlighted[i]
            
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    set_gemslot(_c, rand_slot)
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
        info_queue[#info_queue + 1] = { key = "gemslot_obsidian", set = "Other", vars = {} }
        info_queue[#info_queue + 1] = { key = "gemslot_adamite", set = "Other", vars = { G.GAME.probabilities.normal or 1, SMODS.Stickers["gemslot_adamite"].config.chance, SMODS.Stickers["gemslot_adamite"].config.retriggers } }
        info_queue[#info_queue + 1] = { key = "gemslot_epidote", set = "Other", vars = { ((SMODS.Stickers["gemslot_epidote"].config.val_multi - 1) * 100) } }
        info_queue[#info_queue + 1] = { key = "gemslot_topaz", set = "Other", vars = { SMODS.Stickers["gemslot_topaz"].config.dollars } }
        info_queue[#info_queue + 1] = { key = "gemslot_amber", set = "Other", vars = { G.GAME.probabilities.normal or 1, SMODS.Stickers["gemslot_amber"].config.level_up_odds } }
        return { vars = { self.config.max_highlighted } }
    end,

    can_use = function(self, card) 
        local total = #G.jokers.highlighted
        return total <= self.config.max_highlighted and total ~= 0
    end,

    use = function(self, card, area, copier) 
        for i = 1, self.config.max_highlighted do
            local options = { "obsidian", "adamite", "epidote", "topaz", "amber" }
            local rand_slot = "gemslot_"..pseudorandom_element(options, pseudoseed('spectral_shine'))
            local _c = G.jokers.highlighted[i]
            
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    set_gemslot(_c, rand_slot)
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