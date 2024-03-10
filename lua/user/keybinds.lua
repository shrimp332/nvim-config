local map = vim.keymap.set

-- Set Leader
vim.g.mapleader = " "

-- Splits
map("n", "<leader>sv", ":vsplit<CR>", { desc = "Create a verticle split" })
map("n", "<leader>sh", ":split<CR>", { desc = "Create a horizontal split" })
map("n", "<leader>sq", ":q<CR>", { desc = "Quit buffer" })

map("n", "<C-j>", "<C-w>j", { desc = "Move focus to lower buffer" })
map("n", "<C-k>", "<C-w>k", { desc = "Move focus to upper buffer" })
map("n", "<C-l>", "<C-w>l", { desc = "Move focus to right buffer" })
map("n", "<C-h>", "<C-w>h", { desc = "Move focus to left buffer" })

map("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })

-- move lines
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("i", "<A-j>", "<ESC>:m .+1<CR>==gi", { desc = "Move line down" })
map("i", "<A-k>", "<ESC>:m .-2<CR>==gi", { desc = "Move line up" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })

-- Other
map("n", "<C-s>", ":w<CR>", { desc = "Save buffer" })
