-- Empty Gem Slot
SMODS.Sticker{
    key = "gemslot_empty",
    badge_colour = HEX("734226"),
    prefix_config = { key = false },
    rate = 0.0,
    atlas = "slot_atlas",
    pos = { x = 0, y = 0 },
    config = {},

    loc_vars = function(self, info_queue, card)
        return {}
    end,
	draw = function(self, card) --don't draw shine
		G.shared_stickers[self.key].role.draw_major = card
		G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, nil, card.children.center)
	end,
    added = function(self, card) end,
    removed = function(self, card) end,
}

-- Ruby Gem Slot
SMODS.Sticker{
    key = "gemslot_ruby",
    badge_colour = HEX("e3394f"),
    prefix_config = { key = false },
    rate = 0.0,
    atlas = "slot_atlas",
    pos = { x = 1, y = 0 },
    config = { x_mult = 1.2 },

    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.x_mult } }
    end,
	draw = function(self, card) --don't draw shine
		G.shared_stickers[self.key].role.draw_major = card
		G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, nil, card.children.center)
	end,
    added = function(self, card)
        card.ability.x_mult = card.ability.x_mult + (self.config.x_mult - 1)
    end,
    removed = function(self, card)
        card.ability.x_mult = card.ability.x_mult - (self.config.x_mult - 1)
    end
}

-- Pearl Gem Slot
SMODS.Sticker{
    key = "gemslot_pearl",
    badge_colour = HEX("34d2eb"),
    prefix_config = { key = false },
    rate = 0.0,
    atlas = "slot_atlas",
    pos = { x = 2, y = 0 },
    config = {},

    loc_vars = function(self, info_queue, card)
        return {}
    end,
	draw = function(self, card) --don't draw shine
		G.shared_stickers[self.key].role.draw_major = card
		G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, nil, card.children.center)
	end,
    added = function(self, card) end,
    removed = function(self, card) end,
}

-- Topaz Gem Slot
SMODS.Sticker{
    key = "gemslot_topaz",
    badge_colour = HEX("e6af19"),
    prefix_config = { key = false },
    rate = 0.0,
    atlas = "slot_atlas",
    pos = { x = 3, y = 0 },
    config = { dollars = 2 },

    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.x_mult } }
    end,
	draw = function(self, card) --don't draw shine
		G.shared_stickers[self.key].role.draw_major = card
		G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, nil, card.children.center)
	end,
    added = function(self, card)
        card.ability.p_dollars = card.ability.p_dollars + self.config.dollars
    end,
    removed = function(self, card)
        card.ability.p_dollars = card.ability.p_dollars - self.config.dollars
    end
}

-- Amber Gem Slot
SMODS.Sticker{
    key = "gemslot_amber",
    badge_colour = HEX("ff9524"),
    prefix_config = { key = false },
    rate = 0.0,
    atlas = "slot_atlas",
    pos = { x = 4, y = 0 },
    config = { level_up_odds = 3 },

    loc_vars = function(self, info_queue, card)
        return { vars = {G.GAME.probabilities.normal or 1, self.config.level_up_odds} }
    end,
	draw = function(self, card) --don't draw shine
		G.shared_stickers[self.key].role.draw_major = card
		G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, nil, card.children.center)
	end,
    added = function(self, card) end,
    removed = function(self, card) end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.from_playing_card and not context.repetition then
            if pseudorandom(pseudoseed("amber_slot")) < G.GAME.probabilities.normal / self.config.level_up_odds then
                level_current_hand(card, 1)
            end
        elseif context.cardarea == G.jokers and context.before then
            if pseudorandom(pseudoseed("amber_slot")) < G.GAME.probabilities.normal / self.config.level_up_odds then
                level_current_hand(card, 1)
            end
        end
    end
}

-- Opal Gem Slot
SMODS.Sticker{
    key = "gemslot_opal",
    badge_colour = HEX("bfeeb0"),
    prefix_config = { key = false },
    rate = 0.0,
    atlas = "slot_atlas",
    pos = { x = 0, y = 1 },
    config = {},

    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
	draw = function(self, card) --don't draw shine
		G.shared_stickers[self.key].role.draw_major = card
		G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, nil, card.children.center)
	end,
    added = function(self, card) end,
    removed = function(self, card) end,
}

-- Diamond Gem Slot
SMODS.Sticker{
    key = "gemslot_diamond",
    badge_colour = HEX("abd8ff"),
    prefix_config = { key = false },
    rate = 0.0,
    atlas = "slot_atlas",
    pos = { x = 1, y = 1 },
    config = { retriggers = 1 },

    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.retriggers } }
    end,
	draw = function(self, card) --don't draw shine
		G.shared_stickers[self.key].role.draw_major = card
		G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, nil, card.children.center)
	end,
    added = function(self, card) end,
    removed = function(self, card) end,
    calculate = function(self, card, context)
        if context.repetition then
            return {
                message = localize('k_again_ex'),
                repetitions = self.config.retriggers,
                card = card
            }
        end
    end
}