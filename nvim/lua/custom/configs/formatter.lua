local M = {
  filetype = {
    javascript = {
      require('formatter.filetypes.javascript').prettier
    },
    typescript = {
      require('formatter.filetypes.typescript').prettier
    },
    lua = {
      require('formatter.filetypes.lua').stylua
    },
    go = {
      require('formatter.filetypes.go').goimports,
      require('formatter.filetypes.go').gofmt
    }
  }
}

vim.api.nvim_create_autocmd({"BufWritePost"}, {
  command = "FormatWriteLock"
})

return M
