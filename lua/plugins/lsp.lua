return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "rust_analyzer", "tsserver" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
			})
			lspconfig.tsserver.setup({
				capabilities = capabilities,
			})

			vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { desc = "LSP Hover" })
			vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { desc = "LSP Define" })
			vim.keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, { desc = "LSP Declare" })
			vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "LSP CA" })
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			null_ls.setup({
				sources = {
					-- lua
					null_ls.builtins.formatting.stylua,
					-- ruby
					null_ls.builtins.diagnostics.rubocop,
					null_ls.builtins.formatting.rubocop,
					-- Javascript
					-- null_ls.builtins.diagnostics.esling,
					null_ls.builtins.formatting.prettier,
				},
				--	on_attach = function(client, bufnr)
				--		if client.supports_method("textDocument/formatting") then
				--			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				--			vim.api.nvim_create_autocmd("BufWritePre", {
				--				group = augroup,
				--				buffer = bufnr,
				--				callback = function()
				--					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
				--					-- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
				--					vim.lsp.buf.format({ async = false })
				--				end,
				--			})
				--		end
				--	end,
			})

			vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "LSP Format" })
		end,
	},
}
