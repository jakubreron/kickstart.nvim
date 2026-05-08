vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.vimwiki_list = {
  {
    path = vim.fn.expand '$VIMWIKI_DIR',
    syntax = 'markdown',
    ext = '.md',
  },
}

-- must be set before vim-tmux-navigator loads
vim.g.tmux_navigator_no_wrap = 1
vim.g.tmux_navigator_disable_when_zoomed = 1

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

vim.filetype.add {
  pattern = {
    ['.*/hypr/.*%.conf'] = 'hyprlang',
    ['[jt]sconfig.*.json'] = 'jsonc',
    ['%.env.*'] = 'sh',
  },
  extension = {
    tfvars = 'tf',
  },
}

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

local gh = function(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'L3MON4D3/LuaSnip',
  gh 'saghen/blink.cmp',
  gh 'nat-418/boole.nvim',
  gh 'coder/claudecode.nvim',
  gh 'stevearc/conform.nvim',
  gh 'j-hui/fidget.nvim',
  gh 'rafamadriz/friendly-snippets',
  gh 'lewis6991/gitsigns.nvim',
  gh 'ellisonleao/gruvbox.nvim',
  gh 'folke/lazydev.nvim',
  gh 'mason-org/mason-lspconfig.nvim',
  gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  gh 'mason-org/mason.nvim',
  gh 'nvim-mini/mini.nvim',
  gh 'nvim-neotest/neotest',
  gh 'haydenmeade/neotest-jest',
  gh 'marilari88/neotest-vitest',
  gh 'MunifTanjim/nui.nvim',
  gh 'neovim/nvim-lspconfig',
  gh 'nvim-neotest/nvim-nio',
  gh 'nvim-pack/nvim-spectre',
  gh 'kylechui/nvim-surround',
  { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' },
  gh 'stevearc/oil.nvim',
  gh 'eero-lehtinen/oklch-color-picker.nvim',
  gh 'vuki656/package-info.nvim',
  gh 'nvim-lua/plenary.nvim',
  gh 'folke/snacks.nvim',
  gh 'Wansmer/treesj',
  gh 'folke/ts-comments.nvim',
  gh 'tpope/vim-obsession',
  gh 'christoomey/vim-tmux-navigator',
  gh 'vimwiki/vimwiki',
}

require 'custom.colorscheme'
require 'custom.plugins'
require 'custom.config'

-- vim: ts=2 sts=2 sw=2 et
