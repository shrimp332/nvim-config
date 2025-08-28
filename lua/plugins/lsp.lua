return {
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        version = '1.*',
        opts = {
            keymap = { preset = 'default' },

            appearance = {
                nerd_font_variant = 'mono'
            },

            completion = { documentation = { auto_show = false } },

            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },
    {
        "folke/trouble.nvim",
        opts = {},
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
        }
    },
    {
        {
            "mason-org/mason-lspconfig.nvim",
            opts = {},
            lazy = false,
            dependencies = {
                { "mason-org/mason.nvim", opts = {}, lazy = false },
                "neovim/nvim-lspconfig",
            },
            init = function()
                vim.opt.signcolumn = "yes"

                vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
                vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
                vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
                vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
                vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
                vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")
                vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
                vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")
                vim.keymap.set({ "n", "x" }, "<leader>lf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>")
                vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>")

                vim.lsp.config("emmet_language_server", {
                    filetypes = { "astro", "css", "eruby", "html", "htmlangular", "htmldjango", "javascriptreact", "less", "pug", "sass", "scss", "svelte", "templ", "typescriptreact", "vue", "php" },
                })
            end,
        },
    },
}
