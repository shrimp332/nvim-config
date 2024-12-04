local opt = vim.opt

-- Sets tab spacing to be 4 spaces
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

-- Enable Clipboard support
opt.clipboard = "unnamedplus"

-- Add relative line numbers
opt.number = true
opt.relativenumber = true

-- Keybinds
local map = vim.keymap.set

-- Move between splits
-- map("n", "<C-j>", "<C-w>j", { desc = "Move focus to lower buffer" })
-- map("n", "<C-k>", "<C-w>k", { desc = "Move focus to upper buffer" })
-- map("n", "<C-l>", "<C-w>l", { desc = "Move focus to right buffer" })
-- map("n", "<C-h>", "<C-w>h", { desc = "Move focus to left buffer" })

-- Move lines
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("i", "<A-j>", "<ESC>:m .+1<CR>==gi", { desc = "Move line down" })
map("i", "<A-k>", "<ESC>:m .-2<CR>==gi", { desc = "Move line up" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })

map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

map("t", "<Esc>", "<C-\\><C-n>", { desc = "exit terminal insert mode" })
