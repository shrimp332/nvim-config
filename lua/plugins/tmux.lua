return {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    config = function()
        local map = vim.keymap.set
        map("n", "<C-h>", ":TmuxNavigateLeft<CR>", { desc = "Navigate left in tmux" })
        map("n", "<C-j>", ":TmuxNavigateDown<CR>", { desc = "Navigate down in tmux" })
        map("n", "<C-k>", ":TmuxNavigateUp<CR>", { desc = "Navigate up in tmux" })
        map("n", "<C-l>", ":TmuxNavigateRight<CR>", { desc = "Navigate right in tmux" })
    end,
}
