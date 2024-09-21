return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		null_ls.setup({
			sources = {
				-- lua
				null_ls.builtins.formatting.stylua,

				-- go
				null_ls.builtins.formatting.gofmt,
				null_ls.builtins.formatting.golines,
				null_ls.builtins.formatting.goimports,
				-- js
				null_ls.builtins.formatting.prettier,
				require("none-ls.diagnostics.eslint_d"),
				-- python
				null_ls.builtins.formatting.black,

				-- c++
				null_ls.builtins.formatting.clang_format,
			},

			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({
						group = augroup,
						buffer = bufnr,
					})
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr })
							vim.lsp.buf.format({ timeout = 2000 })
						end,
					})
				end
			end,
		})
	end,
}
