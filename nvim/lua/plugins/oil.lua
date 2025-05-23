return {
  'stevearc/oil.nvim',
  opts = {},
  config = function ()
    require("oil").setup()
    
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end,
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
}
