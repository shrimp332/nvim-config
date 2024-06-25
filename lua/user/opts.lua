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

-- Splits right & below
opt.splitbelow = true
opt.splitright = true

-- Set soft line limit
-- opt.colorcolumn = 80

opt.mousescroll="ver:2,hor:2"
