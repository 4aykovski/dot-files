return {
  "christoomey/vim-tmux-navigator",

  vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", { desc = "window left" }),
  vim.keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", { desc = "window down" }),
  vim.keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", { desc = "window up" }),
  vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", { desc = "window right" }),
  vim.keymap.set("n", "<C-\\>", ":TmuxNavigatePrevious<CR>", { desc = "window previous" }),
}
