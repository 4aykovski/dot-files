return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup()

			vim.keymap.set("n", "<leader>m", function()
				harpoon:list():add()
			end, { desc = "harpoon add" })
			vim.keymap.set("n", "<C-m>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end, { desc = "harpoon quick" })
			vim.keymap.set("n", "<C-a>", function()
				harpoon:list():select(1)
			end, {})
			vim.keymap.set("n", "<C-x>", function()
				harpoon:list():select(2)
			end, {})
			vim.keymap.set("n", "<C-i>", function()
				harpoon:list():select(3)
			end, {})
			vim.keymap.set("n", "<C-p>", function()
				harpoon:list():select(4)
			end, {})
		end,
	},
}
