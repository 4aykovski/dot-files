return {
  "folke/trouble.nvim",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  vim.keymap.set("n", "<leader>yx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Trouble diagnostics" }),
  vim.keymap.set(
    "n",
    "<leader>yX",
    "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
    { desc = "Trouble buffer diagnostics" }
  ),
  vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Trouble symbols" }),
  vim.keymap.set(
    "n",
    "<leader>cl",
    "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
    { desc = "Trouble lsp" }
  ),
  vim.keymap.set("n", "<leader>yL", "<cmd>Trouble loclist toggle<cr>", { desc = "Trouble loclist" }),
  vim.keymap.set("n", "<leader>yQ", "<cmd>Trouble quickfix toggle<cr>", { desc = "Trouble quickfix" }),
}
