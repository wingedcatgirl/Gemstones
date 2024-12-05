-- Create Atlas
SMODS.Atlas{
    key = "gems",
    path = "gemstones.png",
    px = 71,
    py = 95
}:register()

-- Gemstone Consumable Type
SMODS.ConsumableType{
	key = "Gemstone",
    primary_colour = HEX("d1303e"),
    secondary_colour = HEX("d1303e"),
    collection_rows = { 5, 5 },
    shop_rate = 2,
    loc_txt = {
        collection = "Gemstone Cards",
        name = "Gemstone",
        label = "Gemstone",
        undiscovered = {
            name = "Undiscovered Gemstone",
            text = { "Apply this gem", "to a card to", "discover its ability!" },
        }
    },
    default = "gem-Ruby",
    can_stack = true,
    can_divide = true
}

-- Ruby Gemstone
SMODS.Consumable{
    object_type = "Consumable",
    set = "Gemstone",
    name = "gem-Ruby",
    key = "ruby",
    atlas = "gems",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    cost = 3,
    should_apply = false,
    disovered = true,
    order = 1,
    config = {
        max_highlighted = 1,
        x_mult = 1.2,
        sticker_id = "gemslot_ruby"
    },

    loc_vars = function(self, info_queue)
        info_queue[#info_queue + 1] = { key = self.config.sticker_id, set = "Other", vars = { self.config.x_mult } }
        return { vars = { self.config.max_highlighted } }
    end,

    can_use = function(self, card) return can_use_gemstone_consumeable(self, card) end,
    use = function(self, card, area, copier) use_gemstone_consumeable(self, card, area, copier, true) end,
}

-- Pearl Gemstone
SMODS.Consumable{
    object_type = "Consumable",
    set = "Gemstone",
    name = "gem-Pearl",
    key = "pearl",
    atlas = "gems",
    pos = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },
    cost = 3,
    should_apply = false,
    disovered = true,
    order = 2,
    config = {
        max_highlighted = 1,
        sticker_id = "gemslot_pearl"
    },

    loc_vars = function(self, info_queue)
        info_queue[#info_queue + 1] = { key = self.config.sticker_id, set = "Other", vars = {} }
        return { vars = { self.config.max_highlighted } }
    end,

    can_use = function(self, card) 
        return 
        #G.hand.highlighted == self.config.max_highlighted
        and
        get_gemslot(G.hand.highlighted[1]) ~= nil 
    end,
    use = function(self, card, area, copier) use_gemstone_consumeable(self, card, area, copier, true) end,
}

-- Topaz Gemstone
SMODS.Consumable{
    object_type = "Consumable",
    set = "Gemstone",
    name = "gem-Topaz",
    key = "topaz",
    atlas = "gems",
    pos = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },
    cost = 3,
    should_apply = false,
    disovered = true,
    order = 3,
    config = {
        max_highlighted = 1,
        money_earned = 2,
        sticker_id = "gemslot_topaz"
    },

    loc_vars = function(self, info_queue)
        info_queue[#info_queue + 1] = { key = self.config.sticker_id, set = "Other", vars = { self.config.money_earned } }
        return { vars = { self.config.max_highlighted } }
    end,

    can_use = function(self, card) 
        return 
        #G.hand.highlighted == self.config.max_highlighted
        and
        get_gemslot(G.hand.highlighted[1]) ~= nil 
    end,
    use = function(self, card, area, copier) use_gemstone_consumeable(self, card, area, copier, true) end,
}

-- Amber Gemstone
SMODS.Consumable{
    object_type = "Consumable",
    set = "Gemstone",
    name = "gem-Amber",
    key = "amber",
    atlas = "gems",
    pos = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },
    cost = 3,
    should_apply = false,
    disovered = true,
    order = 4,
    config = {
        max_highlighted = 1,
        level_up_odds = 3,
        sticker_id = "gemslot_amber"
    },

    loc_vars = function(self, info_queue)
        info_queue[#info_queue + 1] = { key = self.config.sticker_id, set = "Other", vars = { G.GAME.probabilities.normal or 1, self.config.level_up_odds } }
        return { vars = { self.config.max_highlighted } }
    end,

    can_use = function(self, card) return can_use_gemstone_consumeable(self, card) end,
    use = function(self, card, area, copier) use_gemstone_consumeable(self, card, area, copier, true) end,
}

-- Opal Gemstone
SMODS.Consumable{
    object_type = "Consumable",
    set = "Gemstone",
    name = "gem-Opal",
    key = "opal",
    atlas = "gems",
    pos = { x = 4, y = 0 },
    soul_pos = { x = 4, y = 1 },
    cost = 3,
    should_apply = false,
    disovered = true,
    order = 5,
    config = {
        max_highlighted = 1,
        level_up_odds = 3,
        sticker_id = "gemslot_opal"
    },

    loc_vars = function(self, info_queue)
        info_queue[#info_queue + 1] = { key = self.config.sticker_id, set = "Other", vars = {} }
        return { vars = { self.config.max_highlighted } }
    end,

    can_use = function(self, card) 
        return 
        #G.hand.highlighted == self.config.max_highlighted
        and
        get_gemslot(G.hand.highlighted[1]) ~= nil 
    end,
    use = function(self, card, area, copier) use_gemstone_consumeable(self, card, area, copier, true) end,
}

-- Diamond Gemstone
SMODS.Consumable{
    object_type = "Consumable",
    set = "Gemstone",
    name = "gem-Diamond",
    key = "diamond",
    atlas = "gems",
    pos = { x = 5, y = 0 },
    soul_pos = { x = 5, y = 1 },
    cost = 3,
    should_apply = false,
    disovered = true,
    order = 6,
    config = {
        max_highlighted = 1,
        retriggers = 1,
        sticker_id = "gemslot_diamond"
    },

    loc_vars = function(self, info_queue)
        info_queue[#info_queue + 1] = { key = self.config.sticker_id, set = "Other", vars = { self.config.retriggers } }
        return { vars = { self.config.max_highlighted } }
    end,

    can_use = function(self, card) 
        return 
        #G.hand.highlighted == self.config.max_highlighted
        and
        get_gemslot(G.hand.highlighted[1]) ~= nil 
    end,
    use = function(self, card, area, copier) use_gemstone_consumeable(self, card, area, copier, true) end,
}

-- Amethyst Gemstone
SMODS.Consumable{
    object_type = "Consumable",
    set = "Gemstone",
    name = "gem-Amethyst",
    key = "amethyst",
    atlas = "gems",
    pos = { x = 6, y = 0 },
    soul_pos = { x = 6, y = 1 },
    cost = 3,
    should_apply = false,
    disovered = true,
    order = 7,
    config = {
        max_highlighted = 1,
        h_x_mult = 1.35,
        sticker_id = "gemslot_amethyst"
    },

    loc_vars = function(self, info_queue)
        info_queue[#info_queue + 1] = { key = self.config.sticker_id, set = "Other", vars = { self.config.h_x_mult } }
        return { vars = { self.config.max_highlighted } }
    end,

    can_use = function(self, card) 
        return 
        #G.hand.highlighted == self.config.max_highlighted
        and
        get_gemslot(G.hand.highlighted[1]) ~= nil 
    end,
    use = function(self, card, area, copier) use_gemstone_consumeable(self, card, area, copier, true) end,
}

-- Aquamarine Gemstone
SMODS.Consumable{
    object_type = "Consumable",
    set = "Gemstone",
    name = "gem-Aquamarine",
    key = "aquamarine",
    atlas = "gems",
    pos = { x = 7, y = 0 },
    soul_pos = { x = 7, y = 1 },
    cost = 3,
    should_apply = false,
    disovered = true,
    order = 8,
    config = {
        max_highlighted = 1,
        x_chips = 2,
        sticker_id = "gemslot_aquamarine"
    },

    loc_vars = function(self, info_queue)
        info_queue[#info_queue + 1] = { key = self.config.sticker_id, set = "Other", vars = { self.config.x_chips } }
        return { vars = { self.config.max_highlighted } }
    end,

    can_use = function(self, card) 
        return 
        #G.hand.highlighted == self.config.max_highlighted
        and
        get_gemslot(G.hand.highlighted[1]) ~= nil 
    end,
    use = function(self, card, area, copier) use_gemstone_consumeable(self, card, area, copier, true) end,
}

-- Jade Gemstone
SMODS.Consumable{
    object_type = "Consumable",
    set = "Gemstone",
    name = "gem-Jade",
    key = "jade",
    atlas = "gems",
    pos = { x = 8, y = 0 },
    soul_pos = { x = 8, y = 1 },
    cost = 3,
    should_apply = false,
    disovered = true,
    order = 9,
    config = {
        max_highlighted = 1,
        sticker_id = "gemslot_jade"
    },

    loc_vars = function(self, info_queue)
        info_queue[#info_queue + 1] = { key = self.config.sticker_id, set = "Other", vars = {} }
        return { vars = { self.config.max_highlighted } }
    end,

    can_use = function(self, card) 
        return 
        #G.hand.highlighted == self.config.max_highlighted
        and
        get_gemslot(G.hand.highlighted[1]) ~= nil 
    end,
    use = function(self, card, area, copier) use_gemstone_consumeable(self, card, area, copier, true) end,
}

-- Quartz Gemstone
SMODS.Consumable{
    object_type = "Consumable",
    set = "Gemstone",
    name = "gem-Quartz",
    key = "quartz",
    atlas = "gems",
    pos = { x = 9, y = 0 },
    soul_pos = { x = 9, y = 1 },
    cost = 3,
    should_apply = false,
    disovered = true,
    order = 10,
    config = {
        max_highlighted = 1,
        bonus_chips = 10,
        sticker_id = "gemslot_quartz"
    },

    loc_vars = function(self, info_queue)
        info_queue[#info_queue + 1] = { key = self.config.sticker_id, set = "Other", vars = { self.config.bonus_chips } }
        return { vars = { self.config.max_highlighted } }
    end,

    can_use = function(self, card) 
        return 
        #G.hand.highlighted == self.config.max_highlighted
        and
        get_gemslot(G.hand.highlighted[1]) ~= nil 
    end,
    use = function(self, card, area, copier) use_gemstone_consumeable(self, card, area, copier, true) end,
}

-- Emerald Gemstone
SMODS.Consumable{
    object_type = "Consumable",
    set = "Gemstone",
    name = "gem-Emerald",
    key = "emerald",
    atlas = "gems",
    pos = { x = 0, y = 2 },
    soul_pos = { x = 0, y = 3 },
    cost = 3,
    should_apply = false,
    disovered = true,
    order = 11,
    config = {
        max_highlighted = 1,
        sticker_id = "gemslot_emerald"
    },

    loc_vars = function(self, info_queue)
        info_queue[#info_queue + 1] = { key = self.config.sticker_id, set = "Other", vars = {} }
        return { vars = { self.config.max_highlighted } }
    end,

    can_use = function(self, card) 
        return 
        #G.hand.highlighted == self.config.max_highlighted
        and
        get_gemslot(G.hand.highlighted[1]) ~= nil 
    end,
    use = function(self, card, area, copier) use_gemstone_consumeable(self, card, area, copier, true) end,
}

-- Turquoise Gemstone
SMODS.Consumable{
    object_type = "Consumable",
    set = "Gemstone",
    name = "gem-Turquoise",
    key = "turquoise",
    atlas = "gems",
    pos = { x = 1, y = 2 },
    soul_pos = { x = 1, y = 3 },
    cost = 3,
    should_apply = false,
    disovered = true,
    order = 12,
    config = {
        max_highlighted = 1,
        planets_amount = 1,
        sticker_id = "gemslot_turquoise"
    },

    loc_vars = function(self, info_queue)
        info_queue[#info_queue + 1] = { key = self.config.sticker_id, set = "Other", vars = { self.config.planets_amount } }
        return { vars = { self.config.max_highlighted } }
    end,

    can_use = function(self, card) 
        return 
        #G.hand.highlighted == self.config.max_highlighted
        and
        get_gemslot(G.hand.highlighted[1]) ~= nil 
    end,
    use = function(self, card, area, copier) use_gemstone_consumeable(self, card, area, copier, true) end,
}

-- Epidote Gemstone
SMODS.Consumable{
    object_type = "Consumable",
    set = "Gemstone",
    name = "gem-Epidote",
    key = "epidote",
    atlas = "gems",
    pos = { x = 2, y = 2 },
    soul_pos = { x = 2, y = 3 },
    cost = 3,
    should_apply = false,
    disovered = true,
    order = 13,
    config = {
        max_highlighted = 1,
        val_multi = 1.1,
        sticker_id = "gemslot_epidote"
    },

    loc_vars = function(self, info_queue)
        info_queue[#info_queue + 1] = { key = self.config.sticker_id, set = "Other", vars = { ((self.config.val_multi - 1) * 100) } }
        return { vars = { self.config.max_highlighted } }
    end,

    can_use = function(self, card) 
        return 
        #G.jokers.highlighted <= self.config.max_highlighted
        and
        get_gemslot(G.jokers.highlighted[1]) ~= nil 
    end,
    use = function(self, card, area, copier) use_gemstone_consumeable(self, card, area, copier, true) end,
}

-- Adamite Gemstone
SMODS.Consumable{
    object_type = "Consumable",
    set = "Gemstone",
    name = "gem-Adamite",
    key = "adamite",
    atlas = "gems",
    pos = { x = 3, y = 2 },
    soul_pos = { x = 3, y = 3 },
    cost = 3,
    should_apply = false,
    disovered = true,
    order = 14,
    config = {
        max_highlighted = 1,
        retriggers = 1,
        chance = 2,
        sticker_id = "gemslot_adamite"
    },

    loc_vars = function(self, info_queue)
        info_queue[#info_queue + 1] = { key = self.config.sticker_id, set = "Other", vars = { G.GAME.probabilities.normal or 1, self.config.chance, self.config.retriggers } }
        return { vars = { self.config.max_highlighted } }
    end,

    can_use = function(self, card) 
        return 
        #G.jokers.highlighted == self.config.max_highlighted
        and
        get_gemslot(G.jokers.highlighted[1]) ~= nil 
    end,
    use = function(self, card, area, copier) use_gemstone_consumeable(self, card, area, copier, true) end,
}