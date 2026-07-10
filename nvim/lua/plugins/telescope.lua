return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "andrew-george/telescope-themes",
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          -- Включить перенос строк в окне результатов
          wrap_results = true,

          -- Настройка отображения путей: интеллектуальное отображение
          path_display = { "smart" },

          -- Настройки layout
          layout_config = {
            width = 0.9,
            height = 0.9,
            preview_cutoff = 120,
          },

          -- Клавиши для вертикальной прокрутки
          mappings = {
            i = {
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
            },
            n = {
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
            },
          },
        },
        extensions = {
          ["ui-select"] = require("telescope.themes").get_dropdown({}),
        },
      })

      telescope.load_extension("themes")
      telescope.load_extension("ui-select")

      -- find
      vim.keymap.set("n", "<C-f>", builtin.find_files, { desc = "find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "live grep" })
      vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "find old" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "find buffs" })
      vim.keymap.set("n", "<leader>fc", builtin.current_buffer_fuzzy_find, { desc = "fuzzy find" })
      vim.keymap.set(
        "n",
        "<leader>fa",
        "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>",
        { desc = "find all" }
      )

      -- jumps
      vim.keymap.set("n", "<leader>tj", builtin.jumplist, { desc = "jumplist" })
      vim.keymap.set("n", "<leader>tm", "<cmd> Telescope harpoon marks <CR>", { desc = "harpoon marks" })

      -- git
      vim.keymap.set("n", "<leader>tgs", builtin.git_status, { desc = "git status" })
      vim.keymap.set("n", "<leader>tgc", builtin.git_commits, { desc = "git commits" })

      -- lsp
      vim.keymap.set("n", "<leader>tli", builtin.lsp_implementations, { desc = "implementations" })
      vim.keymap.set("n", "<leader>tlr", builtin.lsp_references, { desc = "references" })
      vim.keymap.set("n", "<leader>tld", builtin.lsp_definitions, { desc = "defenitions" })

      -- themes
      vim.keymap.set("n", "<leader>tt", "<cmd> Telescope themes <CR>", { desc = "themes" })
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    -- Конфигурация теперь в основном setup()
  },
}
