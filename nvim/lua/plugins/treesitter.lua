return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "markdown",
        "markdown_inline",
        "c",
        "cpp",
        "css",
        "go",
        "html",
        "gomod",
        "gosum",
        "javascript",
        "json",
        "yaml",
        "sql",
        "typescript",
        "gitignore",
        "bash",
        "php",
      },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
