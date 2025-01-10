-- Defining Globals
Gemstones = SMODS.current_mod
Gemstones_Config = Gemstones.config

-- Undiscovered Sprite
SMODS.UndiscoveredSprite{
    key = 'Gemstone',
    atlas = 'gems',
    pos = { x = 9, y = 4 },
}

-- Mod Icon
SMODS.Atlas{
	key = "modicon",
	path = "modicon.png",
	px = 32,
	py = 32
}

-- Create Classes for easier content production
Gemstones.GemSlot = SMODS.Sticker:extend{
	rate = 0.0,
	order = 100,
	should_apply = false,
    prefix_config = { key = false },
    joker_compat = true,
    card_compat = true,

	draw = function(self, card) --don't draw shine
		G.shared_stickers[self.key].role.draw_major = card
		G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, nil, card.children.center)
	end,
    added = function(self, card) end,
    removed = function(self, card) end,
}

Gemstones.GemstoneConsumable = SMODS.Consumable:extend{
	set = "Gemstone",
	discovered = false,
	should_apply = false,
	cost = 3,
	order = 100,
	config = { max_highlighted = 1, sticker_id = "gemslot_empty" },

    loc_vars = function(self, info_queue)
        info_queue[#info_queue + 1] = { key = self.config.sticker_id, set = "Other", vars = {} }
        return { vars = { self.config.max_highlighted } }
    end,
	can_use = function(self, card) return Gemstones.can_use_gemstone_consumeable(self, card) end,
    use = function(self, card, area, copier) Gemstones.use_gemstone_consumeable(self, card, area, copier) end,
}

-- Load Item Files
local files = NFS.getDirectoryItems(SMODS.current_mod.path .. "content")
for _, file in ipairs(files) do
	print("Gemstones | Loading Item file " .. file)
	local f, err = SMODS.load_file("content/" .. file)
	if err then
		error(err)
	end
	f()
end