if not Gemstones_Config.Gems_Challenges then return end

-- Amber Gamble
SMODS.Challenge{
    key = "amber_gamble",
    order = 1,
    rules = {
        custom = {
            { id = "gems_no_planets" }
        },
        modifiers = {}
    },
    restrictions = {
		banned_cards = {
            { id = "j_astronomer" },
            { id = "j_space" },
            { id = 'j_certificate' },
            { id = 'j_satellite' } ,
            { id = 'j_constellation' },
            { id = 'j_burnt' },
            { id = 'v_telescope' },
            { id = 'v_observatory' },
            { id = "v_planet_merchant" },
            { id = "v_planet_tycoon" },
            { id = "c_high_priestess" },
            { id = "c_gems_turquoise" },
            { id = "c_gems_shine" },
            { id = "c_black_hole" },
            { id = "c_trance" },
            { id = 'p_celestial_normal_1', ids = {
                'p_celestial_normal_1','p_celestial_normal_2','p_celestial_normal_3','p_celestial_normal_4','p_celestial_jumbo_1','p_celestial_jumbo_2','p_celestial_mega_1','p_celestial_mega_2',
            }},
        },
        banned_tags = {
            { id = "tag_meteor" },
            { id = 'tag_orbital' },
        },
		banned_other = {},
    },
    deck = { type = "Challenge Deck" },
    jokers = {
        { id = 'j_space', eternal = true, edition = 'negative', gemslot = "gemslot_amber" },
    },
    consumeables = {},
    vouchers = {},
}

-- Only Flushes
--SMODS.Challenge{
--    key = "only_flushes",
--    order = 2,
--    rules = {
--        custom = {
--            { id = "gems_lock_slot_sapphire" }
--        },
--        modifiers = {}
--    },
--    restrictions = {
--		banned_cards = {
--            { id = "c_gems_infusion" },
--            { id = 'p_gems_gemstone_normal_1', ids = {
--                'p_gems_gemstone_normal_1','p_gems_gemstone_normal_2','p_gems_gemstone_jumbo_1','p_gems_gemstone_mega_1',
--            }},
--        },
--        banned_tags = {
--            { id = "tag_gems_gemstone" },
--        },
--		banned_other = {
--            { id = 'bl_gems_rock', type = 'blind' },
--            { id = 'bl_gems_hammer', type = 'blind' },
--        },
--    },
--    deck = { type = "Challenge Deck" },
--    jokers = {},
--    consumeables = {},
--    vouchers = {},
--}