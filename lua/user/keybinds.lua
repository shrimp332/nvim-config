-- Set Leader
vim.g.mapleader = " "

-- Splits
vim.keymap.set('n', '<leader>sv', ':vsplit<CR>', {desc = "Create a verticle split"})
vim.keymap.set('n', '<leader>sh', ':split<CR>', {desc = "Create a horizontal split"})
vim.cmd("nnoremap <C-j> <C-w>j")
vim.cmd("nnoremap <C-k> <C-w>k")
vim.cmd("nnoremap <C-l> <C-w>l")
vim.cmd("nnoremap <C-h> <C-w>h")
