vim.loader.enable()

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.winborder = 'rounded'
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'

vim.o.complete = ''
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 5
vim.o.sidescrolloff = 5
vim.o.swapfile = false
vim.o.writebackup = false
vim.o.confirm = true

vim.opt.spelllang:append 'cjk'
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

require 'custom.autocmds'
require 'custom.iabbrev'
require 'custom.keymaps'
require 'custom.filetypes'

-- vim: ts=2 sts=2 sw=2 et
