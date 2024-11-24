-- Drill Miner
SMODS.Joker{
    object_type = "Joker",
    name = "gems-Drill Miner",
    key = "drill_miner",
    atlas = "empty_joker",
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    order = 151,
    blueprint_compat = true,
    config = {},

    loc_vars = function(self, info_queue, desc_nodes)
        return {}
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not (context.blueprint_card or card).getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = (function()
                    G.E_MANAGER:add_event(Event({
                        func = function() 
                            local card = create_card('Gemstone',G.consumeables, nil, nil, nil, nil, nil, 'drill_miner')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                            G.GAME.consumeable_buffer = 0
                            return true
                        end}))   
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_gemstone'), colour = G.C.PURPLE})                       
                    return true
                end)}))
        end
    end
}

-- Gem Gauntlet
SMODS.Joker{
    object_type = "Joker",
    name = "gems-Gem Gauntlet",
    key = "gem_gauntlet",
    atlas = "empty_joker",
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 7,
    order = 152,
    blueprint_compat = true,
    config = {
        gem_slot_tally = 0,
        extra = { xmod_increase = 0.1 }
    },

    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.xmod_increase, 1 + (center.ability.extra.xmod_increase * center.ability.gem_slot_tally) } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            if card.ability.gem_slot_tally > 0 then
                return {
                    message = localize{type='variable',key='a_xmult',vars={1 + (card.ability.extra.xmod_increase * card.ability.gem_slot_tally)}},
                    Xmult_mod = 1 + (card.ability.extra.xmod_increase * card.ability.gem_slot_tally), 
                    colour = G.C.MULT
                }
            end
        end
    end,

    update = function(self, card, context)
        if G.STATE == G.STAGES.RUN then
            card.ability.gem_slot_tally = 0
            
            for k, v in pairs(G.playing_cards) do
                for kk, vv in pairs(v.ability) do if string.find(kk, "gemslot") then
                    card.ability.gem_slot_tally = card.ability.gem_slot_tally + 1
                end end
            end

            for i = 1, #G.jokers.cards do
                local j = G.jokers.cards[i]
                for k, v in pairs(j.ability) do if string.find(k, "gemslot") then
                    card.ability.gem_slot_tally = card.ability.gem_slot_tally + 1
                end end
            end
        end
    end
}