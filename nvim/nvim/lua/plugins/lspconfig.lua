return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({})
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "bashls",
          "clangd",
          "tailwindcss",
          "cssls",
          "dockerls",
          "docker_compose_language_service",
          "gopls",
          "html",
          "jsonls",
          "markdown_oxide",
          "phpactor",
          "pyright",
          "sqlls",
          "yamlls",
          "ts_ls",
        },
      })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = {
          "eslint_d",
          "prettier",
          "black",
          "clang-format",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      require("configs.lspconfig")

      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "lsp hover" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "lsp go def" })
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "code action" })
      vim.keymap.set("n", "<leader>ra", vim.lsp.buf.rename, { desc = "rename" })
    end,
  },
}
