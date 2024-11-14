--- STEAMODDED HEADER
--- MOD_NAME: Gemstones
--- MOD_ID: gemstones
--- MOD_AUTHOR: [officialhalo]
--- MOD_DESCRIPTION: A mod that adds Gemstones, which can be applied to cards to give unique effects.
--- BADGE_COLOR: ba1728
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-0812d]
--- DISPLAY_NAME: Gemstones
--- VERSION: 1.0.0

----------------------------------------------
------------MOD CODE -------------------------

-- Atlas
SMODS.Atlas{
    key = "gems_atlas",
    path = "Tarots.png",
    px = 71,
    py = 95
}:register()

-- Gemstone Consumable
SMODS.ConsumableType{
	key = "Gemstone",
    primary_colour = HEX("8c36a3"),
    secondary_colour = HEX("622473"),
    collection_rows = { 6, 6 },
    shop_rate = 0.2,
    loc_txt = {
        collection = "Gemstone Cards",
        name = "Gemstone",
        label = "Gemstone",
        undiscovered = {
            name = "Undiscovered Gemstone",
            text = { "discover it" },
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
    order = 1,
    loc_txt = {
        name = "Ruby",
        text = {
            "{X:mult,C:white}X#1.2#{} Mult",
            "when scored"
        }
    },
    config = {
        max_highlighted = 1,
    },

    loc_vars = function(self, info_queue)
        return { vars = {self.config.mult, self.config.chips, self.config.money, self.config.x_mult, } }
    end,

    can_use = function(self, card)
        if G.hand.highlighted == 1 then
            return true
        end
    end,
    
    use = function(self, card, area, copier)
        print(card, area, copier)
    end,

    disovered = true,
}

----------------------------------------------
------------MOD CODE END----------------------