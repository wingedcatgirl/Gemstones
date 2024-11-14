--- STEAMODDED HEADER
--- MOD_NAME: Gemstones
--- MOD_ID: gemstones
--- MOD_AUTHOR: [officialhalo]
--- MOD_DESCRIPTION: A mod that adds Gemstones, which can be applied to cards to give unique effects.
--- BADGE_COLOR: ba1728
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-0812d]
--- DISPLAY_NAME: Gemstones
--- VERSION: 0.0.1

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
            "{X:mult,C:white}X#1#{} Mult",
            "when scored"
        }
    },
    config = {
        max_highlighted = 1,
        x_mult = 1.2,
    },

    loc_vars = function(self, info_queue)
        return { vars = { self.config.x_mult } }
    end,

    can_use = function(self, card)
        if #G.hand.highlighted == 1 then
            return true
        end
    end,
    
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                for i = 1, card.ability.max_highlighted do
                    local highlighted = G.hand.highlighted[i]

                    if highlighted then
                        sendDebugMessage("Gem Slot for card held: "..highlighted.gem_slot, "Gemstone")
                    else
                        break
                    end
                end
                return true
            end
        }))
    end,

    disovered = true,
}

----------------------------------------------
------------MOD CODE END----------------------