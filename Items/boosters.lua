-- Booster Pack 1
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
    draw_hand = false, 
    unlocked = true,
    discovered = true,
    
    create_card = function(self, card)
        return create_card('Gemstone', G.pack_cards, nil, nil, true, true, nil, "gem-Ruby")
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.config.center.config.choose, card.ability.extra } }
    end
}