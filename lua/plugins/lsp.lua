local lsps = {
	"lua_ls",
	"bashls",
	"rust_analyzer",
	"tsserver",
	-- "intelephense",
	"clangd",
	"pylsp",
	-- "csharp_ls",
	-- "emmet_language_server",
	-- "rubocop",
	-- "jdtls",
	-- "cssls",
	"nil_ls",
	-- "marksman",
	"gopls",
	"templ",
	"htmx",
	"html",
	"cssls",
	"svelte",
	"texlab",
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
			vim.keymap.set("n", "<leader>lr", ":LspRestart<CR>", { desc = "LSP Restart" })
			vim.keymap.set("n", "<leader>lR", ":lua vim.lsp.buf.rename()<CR>", { desc = "LSP Rename symbol" })
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
					-- Make
					null_ls.builtins.diagnostics.checkmake,
					-- Go
					null_ls.builtins.formatting.gofumpt,
					null_ls.builtins.formatting.goimports_reviser,
					null_ls.builtins.formatting.golines,
					-- JS/TS
					-- null_ls.builtins.formatting.biome
				},

				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
								-- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
								vim.lsp.buf.format({ async = false })
							end,
						})
					end
				end,
			})

			vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "LSP Format" })
		end,
	},
	-- {
	-- 	"dgagn/diagflow.nvim",
	-- 	event = "LspAttach",
	-- 	opts = {},
	-- },
	-- vim.diagnostic.config({
	-- 	virtual_text = false,
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	}, -- })
}
