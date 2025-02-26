return {
	"fredrikaverpil/godoc.nvim",
	version = "*",
	dependencies = {
		{ "nvim-telescope/telescope.nvim" }, -- optional
		{
			"nvim-treesitter/nvim-treesitter",
			opts = {
				ensure_installed = { "go" },
			},
		},
	},
	build = "go install github.com/lotusirous/gostdsym/stdsym@latest", -- optional
	cmd = { "GoDoc" }, -- optional
	opts = {
		picker = {
			type = "telescope",
		},
	},
	vim.keymap.set("n", "<leader>gd", "<cmd>GoDoc<cr>", { desc = "GoDoc" }),
}
