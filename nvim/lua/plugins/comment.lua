return {
  "numToStr/Comment.nvim",
  config = function()
    require("Comment").setup()

    vim.keymap.set("n", "<leader>/", require("Comment.api").toggle.linewise.current, { desc = "comment line" })
  end,
}
