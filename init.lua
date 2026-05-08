vim.loader.enable()

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

-- run TSUpdate whenever nvim-treesitter is updated
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
      vim.cmd 'TSUpdate'
    end
  end,
})

-- plugins loaded eagerly on every startup
vim.pack.add {
  'https://github.com/L3MON4D3/LuaSnip',
  'https://github.com/saghen/blink.cmp',
  'https://github.com/coder/claudecode.nvim',
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/j-hui/fidget.nvim',
  'https://github.com/rafamadriz/friendly-snippets',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/ellisonleao/gruvbox.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/nvim-mini/mini.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/folke/snacks.nvim',
  'https://github.com/tpope/vim-obsession',
  'https://github.com/christoomey/vim-tmux-navigator',
  'https://github.com/stevearc/oil.nvim',
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
}

-- plugins loaded lazily (added via vim.pack.add inside their triggers in plugins.lua)
-- https://github.com/nat-418/boole.nvim        — BufReadPost
-- https://github.com/stevearc/oil.nvim          — eager (netrw hijack)
-- https://github.com/nvim-pack/nvim-spectre     — <leader>ra / <leader>ru
-- https://github.com/kylechui/nvim-surround     — BufReadPost
-- https://github.com/folke/ts-comments.nvim     — BufReadPost
-- https://github.com/Wansmer/treesj            — gJ / gS
-- https://github.com/eero-lehtinen/oklch-color-picker.nvim — <leader>c
-- https://github.com/nvim-neotest/neotest        — FileType js/ts
-- https://github.com/haydenmeade/neotest-jest   — FileType js/ts
-- https://github.com/marilari88/neotest-vitest  — FileType js/ts
-- https://github.com/nvim-neotest/nvim-nio       — FileType js/ts
-- https://github.com/vuki656/package-info.nvim  — BufRead package.json
-- https://github.com/vimwiki/vimwiki            — BufEnter $VIMWIKI_DIR / <leader>w

require 'custom.colorscheme'
require 'custom.plugins'
require 'custom.config'

-- vim: ts=2 sts=2 sw=2 et
