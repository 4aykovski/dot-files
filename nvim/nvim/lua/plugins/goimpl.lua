return {
	"edolphin-ydf/goimpl.nvim",
	config = function()
		require("telescope").load_extension("goimpl")

		vim.api.nvim_set_keymap(
			"n",
			"<leader>gi",
			[[<cmd>lua require'telescope'.extensions.goimpl.goimpl{}<CR>]],
			{ noremap = true, silent = true }
		)
	end,
}
