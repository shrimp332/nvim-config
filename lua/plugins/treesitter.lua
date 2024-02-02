return {
    "nvim-treesitter/nvim-treesitter", 
    build = ":TSUpdate",
    config = function()
        -- Treesitter setup
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "c", "lua", "vim", "javascript", "html", "css", "ruby", "rust" },
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        }
        )
    end
}
