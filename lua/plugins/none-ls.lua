return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				-- lua
				null_ls.builtins.formatting.stylua,
				-- ruby
				null_ls.builtins.diagnostics.rubocop,
				null_ls.builtins.formatting.rubocop,
				-- Javascript
				null_ls.builtins.diagnostics.esling,
				null_ls.builtins.formatting.prettier,
			},
		})

		vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "LSP Format" })
	end,
}
