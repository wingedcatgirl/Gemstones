-- Empty Gem Slot
SMODS.Sticker{
    key = "gemslot_empty",
    badge_colour = HEX("734226"),
    prefix_config = { key = false },
    rate = 0.0,
    order = 1,
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
        return { vars = { G.GAME.probabilities.normal or 1, self.config.level_up_odds } }
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

-- Amethyst Gem Slot
SMODS.Sticker{
    key = "gemslot_amethyst",
    badge_colour = HEX("c41ed6"),
    prefix_config = { key = false },
    rate = 0.0,
    atlas = "slot_atlas",
    pos = { x = 2, y = 1 },
    config = { h_x_mult = 1.35 },

    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.h_x_mult } }
    end,
	draw = function(self, card) --don't draw shine
		G.shared_stickers[self.key].role.draw_major = card
		G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, nil, card.children.center)
	end,
    added = function(self, card)
        card.ability.h_x_mult = card.ability.h_x_mult + self.config.h_x_mult
    end,
    removed = function(self, card)
        card.ability.h_x_mult = card.ability.h_x_mult - self.config.h_x_mult
    end
}

-- Aquamarine Gem Slot
SMODS.Sticker{
    key = "gemslot_aquamarine",
    badge_colour = HEX("80b8c7"),
    prefix_config = { key = false },
    rate = 0.0,
    atlas = "slot_atlas",
    pos = { x = 3, y = 1 },
    config = { x_chips = 2 },

    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.x_chips } }
    end,
	draw = function(self, card) --don't draw shine
		G.shared_stickers[self.key].role.draw_major = card
		G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, nil, card.children.center)
	end,
    added = function(self, card)
        card.ability.x_chips = card.ability.x_chips + self.config.x_chips
    end,
    removed = function(self, card)
        card.ability.x_chips = card.ability.x_chips - self.config.x_chips
    end
}

-- Jade Gem Slot
SMODS.Sticker{
    key = "gemslot_jade",
    badge_colour = HEX("0db813"),
    prefix_config = { key = false },
    rate = 0.0,
    atlas = "slot_atlas",
    pos = { x = 4, y = 1 },
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

-- Quartz Gem Slot
SMODS.Sticker{
    key = "gemslot_quartz",
    badge_colour = HEX("fff3d1"),
    prefix_config = { key = false },
    rate = 0.0,
    atlas = "slot_atlas",
    pos = { x = 0, y = 2 },
    config = { bonus_chips = 10 },

    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.bonus_chips } }
    end,
	draw = function(self, card) --don't draw shine
		G.shared_stickers[self.key].role.draw_major = card
		G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, nil, card.children.center)
	end,
    added = function(self, card) end,
    removed = function(self, card) end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.from_playing_card and not context.repetition then
            card.ability.perma_bonus = card.ability.perma_bonus or 0
            card.ability.perma_bonus = card.ability.perma_bonus + self.config.bonus_chips
            
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex'), colour = G.C.CHIPS})
        end
    end
}

-- Emerald Gem Slot
SMODS.Sticker{
    key = "gemslot_emerald",
    badge_colour = HEX("159d49"),
    prefix_config = { key = false },
    rate = 0.0,
    atlas = "slot_atlas",
    pos = { x = 1, y = 2 },
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

-- Turquoise Gem Slot
SMODS.Sticker{
    key = "gemslot_turquoise",
    badge_colour = HEX("52bab1"),
    prefix_config = { key = false },
    rate = 0.0,
    atlas = "slot_atlas",
    pos = { x = 2, y = 2 },
    config = { planets_amount = 1 },

    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.planets_amount } }
    end,
	draw = function(self, card) --don't draw shine
		G.shared_stickers[self.key].role.draw_major = card
		G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, nil, card.children.center)
	end,
    added = function(self, card) end,
    removed = function(self, card) end,
    calculate = function(self, card, context)
		if context.destroying_card then
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.0,
				func = function()
					local card_type = "Planet"
					local _planet = nil
					if G.GAME.last_hand_played then
						for k, v in pairs(G.P_CENTER_POOLS.Planet) do
							if v.config.hand_type == G.GAME.last_hand_played then
								_planet = v.key
								break
							end
						end
					end

					for i = 1, self.config.planets_amount do
						local card = create_card(card_type, G.consumeables, nil, nil, nil, nil, _planet, "gemslot_turquoise")

						card:set_edition({ negative = true }, true)
						card:add_to_deck()
						G.consumeables:emplace(card)
					end
					return true
				end,
			}))

			return true
		end
	end,
}

-- Epidote Gem Slot
SMODS.Sticker{
    key = "gemslot_epidote",
    badge_colour = HEX("7c822b"),
    prefix_config = { key = false },
    rate = 0.0,
    atlas = "slot_atlas",
    pos = { x = 3, y = 2 },
    config = { val_multi = 1.05 },

    loc_vars = function(self, info_queue, card)
        return { vars = { ((self.config.val_multi - 1) * 100) } }
    end,
	draw = function(self, card) --don't draw shine
		G.shared_stickers[self.key].role.draw_major = card
		G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, nil, card.children.center)
	end,
    added = function(self, card) end,
    removed = function(self, card) end,
    calculate = function(self, card, context)
        if context.post_trigger and card == context.other_joker and not context.blueprint then
            inc_joker_value(card, self.config.val_multi)
            return nil, true
        end
    end
}

-- Adamite Gem Slot
SMODS.Sticker{
    key = "gemslot_adamite",
    badge_colour = HEX("783435"),
    prefix_config = { key = false },
    rate = 0.0,
    atlas = "slot_atlas",
    pos = { x = 4, y = 2 },
    config = { retriggers = 1, chance = 2 },

    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal or 1, self.config.chance, self.config.retriggers } }
    end,
	draw = function(self, card) --don't draw shine
		G.shared_stickers[self.key].role.draw_major = card
		G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, nil, card.children.center)
	end,
    added = function(self, card) end,
    removed = function(self, card) end,
    calculate = function(self, card, context)
        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= card then
            if pseudorandom(pseudoseed("adamite_slot")) < G.GAME.probabilities.normal / self.config.chance then
			    return {
			    	message = localize("k_again_ex"),
			    	repetitions = self.config.retriggers,
			    	card = card,
			    }
            end
		end
    end
}   