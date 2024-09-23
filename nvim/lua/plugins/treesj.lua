return {
	"Wansmer/treesj",
	keys = {
		{
			"gJ",
			function()
				require("treesj").join()
			end,
			desc = "Join",
		},
		{
			"gS",
			function()
				require("treesj").split()
			end,
			desc = "Split",
		},
		{
			"gM",
			function()
				require("treesj").toggle()
			end,
			desc = "Toggle",
		},
	},
	dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
	config = function()
		local tsj = require("treesj")

		tsj.setup({
			use_default_keymaps = false,
			check_syntax_error = true,
			max_join_length = 120,
			cursor_behavior = "hold",
			notify = true,
			dot_repeat = true,
			on_error = nil,
		})
	end,
}
