if not Gemstones_Config.Gems_Vouchers then return end

-- Create Atlas
SMODS.Atlas{
    key = "vouchers",
    path = "vouchers.png",
    px = 71,
    py = 95
}

-- Gemstone Merchant
SMODS.Voucher{
    key = "gemstone_merchant",
    order = 1,
    atlas = "vouchers",
    pos = { x = 0, y = 0 },
    config = { rate_up = 2 },
    
    loc_vars = function(self, info_queue)
		return { vars = { self.config.rate_up } }
	end,
    redeem = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.gemstone_rate = G.GAME.gemstone_rate * self.config.rate_up
				return true
			end,
		}))
	end,
}

-- Gemstone Tycoon
SMODS.Voucher{
    key = "gemstone_tycoon",
    order = 1,
    atlas = "vouchers",
    pos = { x = 0, y = 1 },
    config = { rate_up = 4 },

    loc_vars = function(self, info_queue)
		return { vars = { self.config.rate_up } }
	end,
    redeem = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.gemstone_rate = G.GAME.gemstone_rate * (self.config.rate_up / 2)
				return true
			end,
		}))
	end,
	requires = { "v_gems_gemstone_merchant" },
}