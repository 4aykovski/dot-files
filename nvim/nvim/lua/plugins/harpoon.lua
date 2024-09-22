return {
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
	end,
}
