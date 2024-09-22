vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set relativenumber")

vim.g.mapleader = " "

-- basic keymaps

vim.keymap.set("n", "<Esc>", ":noh<CR>", { desc = "no highlight" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "window left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "window up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "window right" })

vim.keymap.set({ "n", "v" }, "<Up>", "<Nop>", { desc = "disable arrows" })
vim.keymap.set({ "n", "v" }, "<Down>", "<Nop>", { desc = "disable arrows" })
vim.keymap.set({ "n", "v" }, "<Left>", "<Nop>", { desc = "disable arrows" })
vim.keymap.set({ "n", "v" }, "<Right>", "<Nop>", { desc = "disable arrows" })
