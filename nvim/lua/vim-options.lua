vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set relativenumber")
vim.cmd("set clipboard+=unnamedplus")
vim.cmd("set notermguicolors")
vim.cmd("set fileencodings=utf-8,cp1251,koi8-r,cp866")

vim.g.mapleader = " "

-- basic keymaps

vim.keymap.set("n", "<Esc>", ":noh<CR>", { desc = "no highlight" })

vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", { desc = "window left" })
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", { desc = "window down" })
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", { desc = "window up" })
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", { desc = "window right" })

vim.keymap.set({ "n", "v" }, "<Up>", "<Nop>", { desc = "disable arrows" })
vim.keymap.set({ "n", "v" }, "<Down>", "<Nop>", { desc = "disable arrows" })
vim.keymap.set({ "n", "v" }, "<Left>", "<Nop>", { desc = "disable arrows" })
vim.keymap.set({ "n", "v" }, "<Right>", "<Nop>", { desc = "disable arrows" })

vim.keymap.set("n", "<leader>x", "<cmd>bd<CR>", { desc = "close buffer" })

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
  }
)

vim.diagnostic.config({
  virtual_lines = {
    current_line = true
  }
})

