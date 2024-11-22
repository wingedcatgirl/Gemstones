Gemstones = SMODS.current_mod

-- Atlases
SMODS.Atlas{
    key = "gems_atlas",
    path = "gemstones.png",
    px = 71,
    py = 95
}:register()

SMODS.Atlas{
    key = "slot_atlas",
    path = "stickers.png",
    px = 71,
    py = 95
}:register()

SMODS.Atlas{
    key = "empty_joker",
    path = "empty_joker.png",
    px = 71,
    py = 95
}:register()

SMODS.Atlas{
    key = "gemstone_pack",
    path = "boosters.png",
    px = 71,
    py = 95
}:register()

-- Undiscovered Sprite
SMODS.UndiscoveredSprite{
    key = 'Gemstone',
    atlas = 'gems_atlas',
    pos = {x = 5, y = 2},
}

-- SMODS Functions
SMODS.load_file("Items/boosters.lua")()
SMODS.load_file("Items/gemstones.lua")()
SMODS.load_file("Items/stickers.lua")()
SMODS.load_file("Items/tarots.lua")()
SMODS.load_file("Items/utility.lua")()

function Gemstones.reset_game_globals(run_start)
	G.GAME.last_used_gemstone = nil
end