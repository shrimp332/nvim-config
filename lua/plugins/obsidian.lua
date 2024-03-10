return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
        -- Required.
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "hrsh7th/nvim-cmp",

        -- see below for full list of optional dependencies 👇
    },
    opts = {
        workspaces = {
            {
                name = "personal",
                path = "~/Documents/notes",
            },
        },

        -- see below for full list of options 👇
    },
    config = function()
        vim.opt.conceallevel = 1

        vim.keymap.set("n", "<leader>oo", ":ObsidianOpen<CR>", { desc = "Open in obsidian" })
        vim.keymap.set("n", "<leader>ot", ":ObsidianTemplate<CR>", { desc = "Use an Obsidian Template" })
        vim.keymap.set("n", "<leader>ost", ":ObsidianTags<CR>", { desc = "Search for an obsidian tag" })
        vim.keymap.set("n", "<leader>oss", ":ObsidianSearch<CR>", { desc = "Search for an obsidian note" })

        vim.keymap.set("n", "<leader>onb", ":ObsidianNew ./", { desc = "Create a new Note" })
        vim.keymap.set("n", "<leader>onp", ":ObsidianNew 1. Projects/", { desc = "Create a new Project Note" })
        vim.keymap.set("n", "<leader>ons", ":ObsidianNew 2. Study/", { desc = "Create a new Study Note" })
        vim.keymap.set("n", "<leader>ont", ":ObsidianNew 3. Topics/", { desc = "Create a new Topic Note" })
        vim.keymap.set(
            "n",
            "<leader>onw",
            ":ObsidianNew 4. Todo/<CR>:ObsidianTemplate todo-note.md<CR>",
            { desc = "Create a new Todo Note" }
        )

        require("obsidian").setup({
            workspaces = {
                {
                    name = "personal",
                    path = "~/Documents/notes",
                },
            },

            preferred_link_style = "wiki",
            new_notes_location = "current_dir",
            completion = {
                -- Set to false to disable completion.
                nvim_cmp = true,

                -- Trigger completion at 2 chars.
                min_chars = 2,

                -- Where to put new notes created from completion. Valid options are
                --  * "current_dir" - put new notes in same directory as the current buffer.
                --  * "notes_subdir" - put new notes in the default notes subdirectory.
                -- new_notes_location = "current_dir",

                -- Either 'wiki' or 'markdown'.
                -- preferred_link_style = "wiki",

                -- Control how wiki links are completed with these (mutually exclusive) options:
                --
                -- 1. Whether to add the note ID during completion.
                -- E.g. "[[Foo" completes to "[[foo|Foo]]" assuming "foo" is the ID of the note.
                -- Mutually exclusive with 'prepend_note_path' and 'use_path_only'.
                -- prepend_note_id = true,
                -- 2. Whether to add the note path during completion.
                -- E.g. "[[Foo" completes to "[[notes/foo|Foo]]" assuming "notes/foo.md" is the path of the note.
                -- Mutually exclusive with 'prepend_note_id' and 'use_path_only'.
                -- prepend_note_path = false,
                -- 3. Whether to only use paths during completion.
                -- E.g. "[[Foo" completes to "[[notes/foo]]" assuming "notes/foo.md" is the path of the note.
                -- Mutually exclusive with 'prepend_note_id' and 'prepend_note_path'.
                -- use_path_only = false,
            },

            -- Optional, customize how wiki links are formatted.
            ---@param opts {path: string, label: string, id: string|?}
            ---@return string
            wiki_link_func = function(opts)
                if opts.id == nil then
                    return string.format("[[%s]]", opts.label)
                elseif opts.label ~= opts.id then
                    return string.format("[[%s|%s]]", opts.id, opts.label)
                else
                    return string.format("[[%s]]", opts.id)
                end
            end,
            note_id_func = function(title)
                -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
                -- In this case a note with the title 'My new note' will be given an ID that looks
                -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
                local suffix = ""
                if title ~= nil then
                    -- If title is given, transform it into valid file name.
                    suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
                else
                    -- If title is nil, just add 4 random uppercase letters to the suffix.
                    for _ = 1, 4 do
                        suffix = suffix .. string.char(math.random(65, 90))
                    end
                end
                return tostring(os.date("%y-%m-%d")) .. "-" .. suffix
            end,

            -- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
            image_name_func = function()
                -- Prefix image names with timestamp.
                return string.format("%s-", os.time())
            end,

            disable_frontmatter = true,

            templates = {
                subdir = "Templates",
                date_format = "%Y-%m-%d",
                time_format = "%H:%M",
                -- A map for custom variables, the key should be the variable and the value a function
                substitutions = {},
            },

            follow_url_func = function(url)
                -- Open the URL in the default web browser.
                -- vim.fn.jobstart({ "open", url }) -- Mac OS
                vim.fn.jobstart({ "xdg-open", url }) -- linux
            end,

            picker = {
                -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
                name = "telescope.nvim",
                -- Optional, configure key mappings for the picker. These are the defaults.
                -- Not all pickers support all mappings.
                mappings = {
                    -- Create a new note from your query.
                    new = "<C-x>",
                    -- Insert a link to the selected note.
                    insert_link = "<C-l>",
                },
            },

            ui = {
                enable = true, -- set to false to disable all additional syntax features
                update_debounce = 200, -- update delay after a text change (in milliseconds)
                -- Define how various check-boxes are displayed
                checkboxes = {
                    -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
                    [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
                    ["x"] = { char = "", hl_group = "ObsidianDone" },
                    [">"] = { char = "", hl_group = "ObsidianRightArrow" },
                    ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
                    -- Replace the above with this if you don't have a patched font:
                    -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
                    -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

                    -- You can also add more custom ones...
                },
                -- Use bullet marks for non-checkbox lists.
                bullets = { char = "•", hl_group = "ObsidianBullet" },
                external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
                -- Replace the above with this if you don't have a patched font:
                -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
                reference_text = { hl_group = "ObsidianRefText" },
                highlight_text = { hl_group = "ObsidianHighlightText" },
                tags = { hl_group = "ObsidianTag" },
                hl_groups = {
                    -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
                    ObsidianTodo = { bold = true, fg = "#f78c6c" },
                    ObsidianDone = { bold = true, fg = "#89ddff" },
                    ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
                    ObsidianTilde = { bold = true, fg = "#ff5370" },
                    ObsidianBullet = { bold = true, fg = "#89ddff" },
                    ObsidianRefText = { underline = true, fg = "#c792ea" },
                    ObsidianExtLinkIcon = { fg = "#c792ea" },
                    ObsidianTag = { italic = true, fg = "#89ddff" },
                    ObsidianHighlightText = { bg = "#75662e" },
                },
            },

            attachments = {
                -- The default folder to place images in via `:ObsidianPasteImg`.
                -- If this is a relative path it will be interpreted as relative to the vault root.
                -- You can always override this per image by passing a full path to the command instead of just a filename.
                img_folder = "assets/imgs", -- This is the default
                -- A function that determines the text to insert in the note when pasting an image.
                -- It takes two arguments, the `obsidian.Client` and a plenary `Path` to the image file.
                -- This is the default implementation.
                ---@param client obsidian.Client
                ---@param path Path the absolute path to the image file
                ---@return string
                img_text_func = function(client, path)
                    local link_path
                    local vault_relative_path = client:vault_relative_path(path)
                    if vault_relative_path ~= nil then
                        -- Use relative path if the image is saved in the vault dir.
                        link_path = vault_relative_path
                    else
                        -- Otherwise use the absolute path.
                        link_path = tostring(path)
                    end
                    local display_name = vim.fs.basename(link_path)
                    return string.format("![%s](%s)", display_name, link_path)
                end,
            },
            yaml_parser = "native",
        })
    end,
}
