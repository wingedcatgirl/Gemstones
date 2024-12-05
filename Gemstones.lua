Gemstones = SMODS.current_mod

-- Undiscovered Sprite
SMODS.UndiscoveredSprite{
    key = 'Gemstone',
    atlas = 'gems',
    pos = {x = 5, y = 2},
}

--Load Item Files
local files = NFS.getDirectoryItems(SMODS.current_mod.path .. "Items")
for _, file in ipairs(files) do
	print("Gemstones | Loading Item file " .. file)
	local f, err = SMODS.load_file("Items/" .. file)
	if err then
		error(err)
	end
	f()
end

-- SMODS Functions
function Gemstones.reset_game_globals(run_start)
	G.GAME.last_used_gemstone = nil
end