return {
  "luckasRanarison/tailwind-tools.nvim",
  name = "tailwind-tools",
  build = ":UpdateRemotePlugins",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim", -- optional
    "neovim/nvim-lspconfig",       -- optional
  },
  opts = {
    filetypes = {
      "html",
      "javascript",
      "js",
      "jsx",
      "typescript",
      "ts",
      "tsx",
      "vue",
      "typescriptreact",
      "javascriptreact",
    },
  }, -- your configuration

  config = function(_, opts)
    require("tailwind-tools").setup(opts)
  end,
}
