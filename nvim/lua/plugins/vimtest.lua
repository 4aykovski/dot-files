return {
	"vim-test/vim-test",
	dependencies = {
		"preservim/vimux",
	},

	config = function()
		vim.keymap.set("n", "<leader>rt", ":TestNearest<CR>", { desc = "test nearest" })
		vim.keymap.set("n", "<leader>rf", ":TestFile<CR>", { desc = "test file" })
		vim.keymap.set("n", "<leader>rs", ":TestSuite<CR>", { desc = "test suite" })
		vim.keymap.set("n", "<leader>rl", ":TestLast<CR>", { desc = "test last" })
		vim.keymap.set("n", "<leader>rg", ":TestVisit<CR>", { desc = "test visit" })
	end,

	vim.cmd("let test#strategy = 'vimux'"),
}
