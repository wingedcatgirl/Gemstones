if not Gemstones_Config.Gems_Blinds then return end

-- Create Atlas
SMODS.Atlas{
    key = "blinds",
    path = "blind.png",
	atlas_table = "ANIMATION_ATLAS",
    px = 34,
    py = 34,
    frames = 21
}

-- The Rock
SMODS.Blind{
    name = "gems-rock",
    key = "rock",
    dollars = 5,
    mult = 2,
    boss = { min = 1, max = 10 },
    atlas = "blinds",
    pos = { x = 0, y = 0 },
    order = 1,
    boss_colour = HEX("494e52"),
    recalc_debuff = function(self, card, from_blind)
        local k = Gemstones.get_gemslot(card)
        if k and k ~= "gemslot_empty" then
            return true
        end

        return false
    end
}

-- The Hammer
SMODS.Blind{
    name = "gems-Hammer",
    key = "hammer",
    dollars = 5,
    mult = 2,
    boss = { min = 1, max = 10 },
    atlas = "blinds",
    pos = { x = 0, y = 1 },
    order = 2,
    boss_colour = HEX("ff5833"),
    press_play = function(self)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
        for i = 1, #G.play.cards do
            local k = Gemstones.get_gemslot(G.play.cards[i])
            if k and k ~= "gemslot_empty" then
                G.E_MANAGER:add_event(Event({func = function() G.play.cards[i]:juice_up(); return true end })) 
                ease_dollars(-3)
                delay(0.23)
            end
        end
        return true end })) 
        self.triggered = true
        return true
    end
}