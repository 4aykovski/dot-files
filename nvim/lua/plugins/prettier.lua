return {
	"MunifTanjim/prettier.nvim",
	config = function()
		local prettier = require("prettier")
		prettier.setup({
			cli_options = {
				single_attribute_per_line = true,
			},
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
			["none-ls"] = {
				condition = function()
					return prettier.config_exists({
						-- if `false`, skips checking `package.json` for `"prettier"` key
						check_package_json = true,
					})
				end,
				runtime_condition = function(params)
					-- return false to skip running prettier
					return true
				end,
				timeout = 5000,
			},
		})
	end,
}
