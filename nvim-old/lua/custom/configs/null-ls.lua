-- not in use now
local null_ls = require "null-ls"
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local opts = {
  sources = {
    -- go
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.golines,
    null_ls.builtins.formatting.goimports,
    -- js
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.diagnostics.eslint,
    -- python
    null_ls.builtins.formatting.black,
    -- lua
    null_ls.builtins.formatting.stylua,
    -- c++
    null_ls.builtins.formatting.clang_format,
  },
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds {
        group = augroup,
        buffer = bufnr,
      }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
          vim.lsp.buf.format { timeout = 2000 }
        end,
      })
    end
  end,
}
return opts
