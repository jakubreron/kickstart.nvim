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

vim.opt.breakindent = true
vim.opt.showbreak = '↳ '

vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
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

vim.cmd [[
  iabbrev PP PERF:<ESC>gcc^f:a
  iabbrev HH HACK:<ESC>gcc^f:a
  iabbrev TT TODO: @Jakub<ESC>gcc^fba
  iabbrev NN NOTE:<ESC>gcc^f:a
  iabbrev WW WARNING:<ESC>gcc^f:a
  iabbrev FF FIX:<ESC>gcc^f:a

  iabbrev tsi @ts-ignore<ESC>gcc
  iabbrev esi eslint-disable<ESC>gcc
  iabbrev bii biome-ignore<ESC>gcc
]]

vim.filetype.add {
  pattern = {
    ['%.env.*'] = 'sh',
  },
  extension = {
    tfvars = 'tf',
  },
}

require 'autocmds'
require 'keymaps'

-- vim: ts=2 sts=2 sw=2 et
