return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  -- Everything in opts will be passed to setup()
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      vue = { "prettier" },
      go = { "gofmt", "goimports" },
      html = { "prettier" },
      scss = { "prettier" },
      css = { "prettier" },
    },
    -- Set up format-on-save
    format_on_save = { timeout_ms = 100, lsp_fallback = true },
    log_level = vim.log.levels.DEBUG,
    -- Customize formatters
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
    },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
