return {
	"MunifTanjim/prettier.nvim",
	config = function()
		require("prettier").setup({
			bin = "prettier",
			filetypes = {
				"css",
				"graphql",
				"javascript",
				"javascriptreact",
				"json",
				"less",
				"markdown",
				"scss",
				"typescript",
				"typescriptreact",
			},
		})
	end,
}
