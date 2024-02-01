return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim", -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information }
    },
    config = function()
        -- Neotree Setup
        vim.keymap.set('n', '<leader>e', ':Neotree filesystem reveal right<CR>')
        require('neo-tree').setup({
            filesystem = {
                filtered_items = {
                    visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
            },
            event_handlers = {
                {
                    event = "file_opened",
                    handler = function(file_path)
                        -- auto close
                        -- vimc.cmd("Neotree close")
                        -- OR
                        require("neo-tree.command").execute({ action = "close" })
                    end
                },
            },
            window = {
                position = "left",
                width = 40,
                mapping_options = {
                    noremap = true,
                    nowait = true,
                },
            }
        })
    end
}

