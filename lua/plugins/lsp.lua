local lsps = {
	"lua_ls",
	"rust_analyzer",
	"tsserver",
	"intelephense",
	"clangd",
	"pylsp",
	"csharp_ls",
	"emmet_language_server",
	"rubocop",
	"jdtls",
	"cssls",
	"html",
}
return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opt = {
			auto_install = true,
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = lsps,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			for _, lsp in ipairs(lsps) do
				lspconfig[lsp].setup({
					capabilities = capabilities,
				})
			end

			vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { desc = "LSP Hover" })
			vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { desc = "LSP Define" })
			vim.keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, { desc = "LSP Declare" })
			vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "LSP CA" })
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		lazy = false,
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
					-- null_ls.builtins.diagnostics.eslint_d,
					-- null_ls.builtins.formatting.prettier,
					-- Make
					null_ls.builtins.diagnostics.checkmake,
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
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			vim.diagnostic.config({
				virtual_text = false,
			})
			require("lsp_lines").setup()
		end,
	},
}
