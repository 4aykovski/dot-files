return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
				ensure_installed = {
					"lua",
					"vim",
					"vimdoc",
					"markdown",
					"markdown_inline",
					"c",
					"cpp",
					"css",
					"go",
					"html",
					"gomod",
					"gosum",
					"javascript",
					"json",
					"yaml",
					"sql",
					"typescript",
					"gitignore",
					"bash",
					"php",
				},
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					-- Defaults
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = false, -- Auto close on trailing </
				},
			})
		end,
	},
}
