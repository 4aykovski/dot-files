return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	lazy = false,
	config = function()
		require("refactoring").setup()
	end,
	keys = {
		{
			"<leader>rr",
			function()
				require("refactoring").select_refactor()
			end,
			mode = "v",
			noremap = true,
			silent = true,
			expr = false,
			desc = "Select refactoring",
		},
	},
}
