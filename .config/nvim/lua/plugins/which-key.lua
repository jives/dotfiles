return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		-- plugins = { spelling = true },
		defaults = {
			mode = { "n", "v" },
			["g"] = { name = "+Goto" },
			["gs"] = { name = "+Surround" },
			["]"] = { name = "+Next" },
			["["] = { name = "+Prev" },
			-- ["<leader><tab>"] = { name = "+tabs" },
			["<leader>b"] = { name = "+Buffer" },
			["<leader>c"] = { name = "+Code" },
			["<leader>f"] = { name = "+File/Find" },
			["<leader>g"] = { name = "+Git" },
			["<leader>gh"] = { name = "+Hunks" },
			["<leader>q"] = { name = "+Quit/Session" },
			["<leader>s"] = { name = "+Search" },
			["<leader>u"] = { name = "+Ui" },
			["<leader>w"] = { name = "+Windows" },
			["<leader>x"] = { name = "+Diagnostics/Quickfix" },
			["z"] = { name = "+Folds" },
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.register(opts.defaults)
	end,
}
