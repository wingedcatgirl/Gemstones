if CardSleeves then
    -- Create Atlas
    SMODS.Atlas({
        key = "sleeves",
        path = "sleeves.png",
        px = 71,
        py = 95
    })

    -- Crystal Sleeve
    CardSleeves.Sleeve({
        key = "crystal_sleeve",
        name = "Crystal Sleeve",
        atlas = "sleeves",
        pos = { x = 0, y = 0 },
        config = {},
        unlocked = true,
        unlock_condition = { name = "Crystal Deck", stake = 1 },
        loc_vars = function(self)
            local key, vars

            if self.get_current_deck_key() ~= "b_gems_crystal" then
                key = self.key
            else
                key = self.key.."_alt"
            end

            return { key = key, vars = vars }
        end,
        apply = function(self)
            if self.get_current_deck_key() ~= "b_gems_crystal" then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        for i = #G.playing_cards, 1, -1 do
                            Gemstones.set_gemslot(G.playing_cards[i], "gemslot_empty")
                        end
        
                        return true
                    end
                }))
            end
        end,
        trigger_effect = function(self, args)
            if self.get_current_deck_key() == "b_gems_crystal" then
                if args.context.create_card and args.context.card.base.id then
                    Gemstones.set_gemslot(args.context.card, "gemslot_empty")
                end
            end
        end
    })
end