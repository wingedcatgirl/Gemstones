-- Defining Globals
Gemstones = SMODS.current_mod
Gemstones_Config = Gemstones.config

-- Undiscovered Sprite
SMODS.UndiscoveredSprite{
    key = 'Gemstone',
    atlas = 'gems',
    pos = {x = 5, y = 2},
}

-- Mod Icon
SMODS.Atlas{
	key = "modicon",
	path = "modicon.png",
	px = 32,
	py = 32
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