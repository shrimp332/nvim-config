return {
	"DreamMaoMao/yazi.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		vim.keymap.set("n", "<leader>y", ":Yazi<CR>")
	end,
}
