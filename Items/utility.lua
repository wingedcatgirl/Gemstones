-- Check to see if a Gemstone Consumable can be used
function can_use_gemstone_consumeable(self, card)
    return 
    (#G.jokers.highlighted + #G.hand.highlighted) == self.config.max_highlighted
    and
    (get_gemslot(G.jokers.highlighted[1]) or get_gemslot(G.hand.highlighted[1])) ~= nil
end

-- Use and consume a Gemstone
function use_gemstone_consumeable(self, card, area, copier, is_gemstone)
    if is_gemstone == true then G.GAME.last_used_gemstone = self.key end

    for i = 1, #G.hand.highlighted do
        local highlighted = G.hand.highlighted[i]
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                set_gemslot(highlighted, self.config.sticker_id)
                highlighted:juice_up(0.5, 0.5)
    
                card:juice_up(0.5, 0.5)
                play_sound('gold_seal', 1.2, 0.4)
                return true
            end
        }))
    end

    for i = 1, #G.jokers.highlighted do
        local highlighted = G.jokers.highlighted[i]
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                set_gemslot(highlighted, self.config.sticker_id)
                highlighted:juice_up(0.5, 0.5)
    
                card:juice_up(0.5, 0.5)
                play_sound('gold_seal', 1.2, 0.4)
                return true
            end
        }))
    end

    delay(0.6)
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function() G.hand:unhighlight_all(); G.jokers:unhighlight_all(); return true end }))
end

-- Apply gemstone
function set_gemslot(card, id)
    local stickers = SMODS.Stickers

    for k, v in pairs(card.ability) do
        if string.find(k, "gemslot") then
            stickers[k]:removed(card)
            card.ability[k] = nil
        end
    end

    stickers[id]:added(card)
    card.ability[id] = true
end

-- Check for gemstone
function get_gemslot(card)
    if not card then return nil end
    
    for k, v in pairs(card.ability) do
        if string.find(k, "gemslot") then
            return k
        end
    end
end

-- Sticker compatability for playing cards (from Cryptid)
local ec = eval_card
function eval_card(card, context)
	local ret = ec(card, context)
    
	if card.area == G.hand or card.area == G.play or card.area == G.discard or card.area == G.deck then
		for k, v in pairs(SMODS.Stickers) do
			if card.ability[k] and v.calculate and type(v.calculate) == "function" then
				context.from_playing_card = true
				context.ret = ret
				v:calculate(card, context)
			end
		end
	end

	return ret
end

-- Levels currently played hand
function level_current_hand(card, amount)
    local text,disp_text = G.FUNCS.get_poker_hand_info(G.play.cards)
                
    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')})
    update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(text, 'poker_hands'),chips = G.GAME.hands[text].chips, mult = G.GAME.hands[text].mult, level=G.GAME.hands[text].level})
    level_up_hand(card, text, nil, amount)
end

-- Adds a Store button (from Betmma's Vouchers)
local G_UIDEF_use_and_sell_buttons_ref = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
	if (card.area == G.pack_cards and G.pack_cards) and card.ability.consumeable then
		if card.ability.set == "Gemstone" then
			return {
				n = G.UIT.ROOT,
				config = { padding = -0.1, colour = G.C.CLEAR },
				nodes = {
					{
						n = G.UIT.R,
						config = {
							ref_table = card,
							r = 0.08,
							padding = 0.1,
							align = "bm",
							minw = 0.5 * card.T.w - 0.15,
							minh = 0.7 * card.T.h,
							maxw = 0.7 * card.T.w - 0.15,
							hover = true,
							shadow = true,
							colour = G.C.UI.BACKGROUND_INACTIVE,
							one_press = true,
							button = "store_card",
							func = "can_reserve_card",
						},
						nodes = {
							{
								n = G.UIT.T,
								config = {
									text = " STORE ",
									colour = G.C.UI.TEXT_LIGHT,
									scale = 0.55,
									shadow = true,
								},
							},
						},
					},
				}
	        }
		end
	end
	return G_UIDEF_use_and_sell_buttons_ref(card)
end

-- GLOBALS --

G.FUNCS.can_reserve_card = function(e)
	if #G.consumeables.cards < G.consumeables.config.card_limit then
		e.config.colour = G.C.GREEN
		e.config.button = "reserve_card"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

G.FUNCS.reserve_card = function(e)
	local c1 = e.config.ref_table
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 0.1,
		func = function()
			c1.area:remove_card(c1)
			c1:add_to_deck()
			if c1.children.price then
				c1.children.price:remove()
			end
			c1.children.price = nil
			if c1.children.buy_button then
				c1.children.buy_button:remove()
			end
			c1.children.buy_button = nil
			remove_nils(c1.children)
			G.consumeables:emplace(c1)
			G.GAME.pack_choices = G.GAME.pack_choices - 1
			if G.GAME.pack_choices <= 0 then
				G.FUNCS.end_consumeable(nil, delay_fac)
			end
			return true
		end,
	}))
end