vim.g.mapleader = " "

local indentsize = 4

vim.o.autoindent = true
vim.o.breakindent = true
vim.o.clipboard = vim.o.clipboard .. "unnamedplus"
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.hidden = true
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.mouse = vim.o.mouse .. "a"
vim.o.number = true
vim.o.relativenumber = true
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages"
vim.o.shiftwidth = indentsize
vim.o.showmode = false
vim.o.smartindent = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.startofline = false
vim.o.swapfile = false
vim.o.tabstop = indentsize
vim.o.timeoutlen = 1500
vim.o.undodir = vim.fn.stdpath("cache") .. "/undo"
vim.o.undofile = true
vim.o.updatetime = 100
vim.o.wrap = false
