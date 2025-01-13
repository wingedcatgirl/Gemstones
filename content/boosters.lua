-- Create Atlas
SMODS.Atlas{
    key = "gemstone_pack",
    path = "boosters.png",
    px = 71,
    py = 95
}

-- Create Card Booster
local function create_gemstone_booster(self, card, i)
    local _card
    if i == card.ability.extra then
        _card =  create_card("Tarot", G.pack_cards, nil, nil, true, nil, "c_gems_infusion", "ar1")
    else
        _card = create_card('Gemstone', G.pack_cards, nil, nil, true, nil, nil, "gems")
    end

    return _card
end

-- Booster Pack 1
SMODS.Booster{
    name = "Gemstone Pack",
    key = "gemstone_normal_1",
    kind = "Gemstone",
    atlas = "gemstone_pack",
    group_key = "k_gems_gemstone_pack",
    pos = { x = 0, y = 0 },
	config = { extra = 4, choose = 1 },
    cost = 4,
    order = 1,
    weight = 1.2,
    draw_hand = true, 
    unlocked = true,
    discovered = true,
    
    create_card = create_gemstone_booster,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "c_gems_infusion", set = "Tarot", vars = {} }
        return { vars = { card.config.center.config.choose, card.ability.extra - 1 } }
    end
}

-- Booster Pack 2
SMODS.Booster{
    name = "Gemstone Pack",
    key = "gemstone_normal_2",
    kind = "Gemstone",
    atlas = "gemstone_pack",
    group_key = "k_gems_gemstone_pack",
    pos = { x = 1, y = 0 },
	config = { extra = 4, choose = 1 },
    cost = 4,
    order = 1,
    weight = 1.2,
    draw_hand = true, 
    unlocked = true,
    discovered = true,

    create_card = create_gemstone_booster,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "c_gems_infusion", set = "Tarot", vars = {} }
        return { vars = { card.config.center.config.choose, card.ability.extra - 1 } }
    end
}

-- Booster Pack 3
SMODS.Booster{
    name = "Gemstone Pack",
    key = "gemstone_jumbo_1",
    kind = "Gemstone",
    atlas = "gemstone_pack",
    group_key = "k_gems_gemstone_pack",
    pos = { x = 2, y = 0 },
	config = { extra = 6, choose = 1 },
    cost = 6,
    order = 1,
    weight = 0.6,
    draw_hand = true, 
    unlocked = true,
    discovered = true,
    
    create_card = create_gemstone_booster,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "c_gems_infusion", set = "Tarot", vars = {} }
        return { vars = { card.config.center.config.choose, card.ability.extra - 1 } }
    end
}

-- Booster Pack 4
SMODS.Booster{
    name = "Gemstone Pack",
    key = "gemstone_mega_1",
    kind = "Gemstone",
    atlas = "gemstone_pack",
    group_key = "k_gems_gemstone_pack",
    pos = { x = 3, y = 0 },
	config = { extra = 6, choose = 2 },
    cost = 8,
    order = 1,
    weight = 0.6,
    draw_hand = true, 
    unlocked = true,
    discovered = true,
    
    create_card = create_gemstone_booster,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "c_gems_infusion", set = "Tarot", vars = {} }
        return { vars = { card.config.center.config.choose, card.ability.extra - 1 } }
    end
}