if not Gemstones_Config.Gems_Decks then return end

-- Create Atlas
SMODS.Atlas{
    key = "decks",
    path = "decks.png",
    px = 71,
    py = 95
}

-- Crystal Deck
SMODS.Back{
    name = "gems-Crystal",
    key = "crystal",
    atlas = "decks",
    pos = { x = 0, y = 0 },
    config = { gems_set_slot = true, sticker_id = "gemslot_empty" },
    order = 1
}