return {
  {
    "tpope/vim-dadbod",
    opt = true,
    lazy = true,
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "sql",
          "mysql",
          "plsql",
          "psql",
          "oracle",
          "sqlite",
        },
        callback = function()
          require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
        end
      })
    end
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = { "tpope/vim-dadbod" },
    config = function()
      vim.keymap.set("n", "<leader>du", ":DBUIToggle<CR>")
    end,
  },
  {
    "kristijanhusak/vim-dadbod-completion",
    lazy = true,
    dependencies = { "tpope/vim-dadbod" },
  }
}
