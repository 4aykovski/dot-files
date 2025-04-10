return {
  "folke/trouble.nvim",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  vim.keymap.set("n", "<leader>yx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Trouble diagnostics" }),
  vim.keymap.set("n", "gh", ":lua require('trouble').prev({skip_groups = true, jump = true})<cr>",
    { desc = "Trouble prev" }),
  vim.keymap.set("n", "gl", ":lua require('trouble').next({skip_groups = true, jump = true})<cr>",
    { desc = "Trouble next" }),
}
