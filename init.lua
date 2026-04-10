--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.vimwiki_list = {
  {
    path = vim.fn.expand '$VIMWIKI_DIR',
    syntax = 'markdown',
    ext = '.md',
  },
}

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

vim.opt.spelllang:append 'cjk' -- disable spellchecking for asian characters (VIM algorithm does not support it)
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

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then error('Error cloning lazy.nvim:\n' .. out) end
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@module 'snacks'
    ---@type snacks.Config
    opts = {
      picker = {
        hidden = true,
        matcher = {
          frecency = true,
          history_bonus = true,
        },
        win = {
          input = {
            keys = {
              ['<C-k>'] = { 'history_back', mode = { 'i', 'n' } },
              ['<C-j>'] = { 'history_forward', mode = { 'i', 'n' } },
            },
          },
        },
      },
    },
    keys = {
      {
        '<leader>sb',
        function() Snacks.picker.buffers() end,
        desc = '[b]uffers',
      },
      {
        '<leader>sf',
        function() Snacks.picker.smart() end,
        desc = '[f]iles',
      },
      {
        '<leader>sd',
        function() Snacks.picker.diagnostics() end,
        desc = '[d]iagnostic',
      },
      {
        '<leader>svh',
        function() Snacks.picker.help() end,
        desc = '[h]elp',
      },
      {
        '<leader>svc',
        function() Snacks.picker.colorschemes() end,
        desc = '[c]olorscheme',
      },
      {
        '<leader>svk',
        function() Snacks.picker.keymaps() end,
        desc = '[k]eymaps',
      },
      {
        '<leader>st',
        function()
          -- to refine the search, add -- and then ripgrep args, like "-- -g={*.md,*.tsx}"
          -- or press <C-g> and add file:md$
          Snacks.picker.grep()
        end,
        desc = '[t]ext',
      },
      {
        '<leader>sp',
        function() Snacks.picker.projects() end,
        desc = '[p]rojects',
      },
      {
        '<leader>sl',
        function() Snacks.picker.resume() end,
        desc = '[l]ast resume',
      },
      {
        '<leader>su',
        function() Snacks.picker.undo() end,
        desc = '[u]ndo',
      },
      {
        'grd',
        function() Snacks.picker.lsp_definitions() end,
        desc = '[d]efinition',
      },
      {
        'grt',
        function() Snacks.picker.lsp_type_definitions() end,
        desc = '[t]ype definition',
      },
      {
        'grD',
        function() Snacks.picker.lsp_declarations() end,
        desc = '[D]eclaration',
      },
      {
        'grr',
        function() Snacks.picker.lsp_references() end,
        desc = '[r]eferences',
        nowait = true,
      },
      {
        'gri',
        function() Snacks.picker.lsp_implementations() end,
        desc = '[i]mplementation',
      },
      {
        'g0',
        function() Snacks.picker.lsp_symbols() end,
        desc = 'LSP Symbols',
      },
      {
        '<leader>gg',
        function() Snacks.lazygit() end,
        desc = 'lazy[g]it',
      },
      {
        '<leader>gb',
        function() Snacks.git.blame_line() end,
        desc = '[b]lame line',
      },
      {
        '<leader>gc',
        function() Snacks.picker.git_status() end,
        desc = '[c]hanged files',
      },
      {
        '<leader>gB',
        function() Snacks.picker.git_branches() end,
        desc = '[B]ranches',
      },
      {
        '<leader>gd',
        function() Snacks.picker.git_diff() end,
        desc = '[d]iff',
      },
      {
        '<leader>gla',
        function() Snacks.picker.git_log() end,
        desc = '[a]ll',
      },
      {
        '<leader>gll',
        function() Snacks.picker.git_log_line() end,
        desc = '[l]ine',
      },
      {
        '<leader>glf',
        function() Snacks.picker.git_log_file() end,
        desc = '[f]ile',
      },

      {
        '<C-q>',
        function() Snacks.picker.qflist() end,
        desc = '[q]uickfix',
      },
    },
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'mason-org/mason.nvim',
        ---@module 'mason.settings'
        ---@type MasonSettings
        opts = {},
      },

      {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        opts = {
          ensure_installed = {
            -- NOTE: LSP
            'lua-language-server',
            'typescript-language-server',
            'emmet-language-server',
            'bash-language-server',
            'tailwindcss-language-server',
            'stylelint-language-server',
            'json-lsp',
            'markdown-oxide',
            'html-lsp',
            'css-lsp',
            'eslint-lsp',
            'intelephense',
            'gopls',
            'sqls',

            -- NOTE: LSP, formatters, linters
            'stylua',
            'biome',

            -- NOTE: formatters, linters
            'markdownlint',

            -- NOTE: formatters
            'prettier', -- only json because prettierd is bugged
            'prettierd', -- html, yaml, json, etc
          },
        },
      },

      {
        'mason-org/mason-lspconfig.nvim',
        opts = { automatic_enable = true },
      },

      {
        'j-hui/fidget.nvim',
        config = true,
      },

      {
        'saghen/blink.cmp',
        dependencies = {
          'rafamadriz/friendly-snippets',
        },
        event = 'VimEnter',
        version = '*',
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
          sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
            providers = {
              buffer = {
                score_offset = -100, -- Make buffer completions appear at the end.
              },
            },
          },
          cmdline = {
            completion = {
              menu = { auto_show = true },
            },
          },
          completion = {
            menu = {
              draw = {
                columns = {
                  { 'kind_icon' },
                  { 'label', 'label_description', gap = 1 },
                  { 'kind' },
                },
              },
            },
            documentation = {
              auto_show = true,
              auto_show_delay_ms = 0,
            },
          },
        },
      },
    },
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function() require('conform').format { async = true, lsp_format = 'never' } end,
        mode = '',
        desc = '[f]ormat buffer',
      },
    },
    -- This will provide type hinting with LuaLS
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      format_on_save = { lsp_format = 'never' },
      formatters_by_ft = {
        lua = { 'stylua' },

        javascript = { 'biome-check' },
        javascriptreact = { 'biome-check' },
        vue = { 'biome-check' },
        typescript = { 'biome-check' },
        typescriptreact = { 'biome-check' },

        css = { 'biome-check' },
        scss = { 'biome-check' },
        less = { 'biome-check' },
        sass = { 'biome-check' },
        html = { 'biome-check' },
        php = { 'prettier' },
        yaml = { 'prettierd' },
        json = { 'prettier' }, -- NOTE: nice to have prettierd, but it creates bugs in japanese characters

        markdown = { 'markdownlint' },
        vimwiki = { 'markdownlint' },
      },
    },
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ':TSUpdate',
    config = function()
      local filetypes = {
        'bash',
        'c',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'vim',
        'vimdoc',
        'diff',
        'tsx',
        'typescript',
        'comment',
        'javascript',
        'css',
        'scss',
        'vue',
        'json',
        'jsdoc',
        'yaml',
        'toml',
        'hyprlang',
        'regex',
        'query',
      }

      require('nvim-treesitter').install(filetypes)

      -- Only attach Tree-sitter if a parser exists for the buffer's filetype
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { '*' },
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          if lang and vim.treesitter.language.add(lang) then vim.treesitter.start(args.buf) end
        end,
      })
    end,
  },

  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  { import = 'custom.plugins' },
  { import = 'custom.colorscheme' },
}

require 'custom.autocmds'
require 'custom.iabbrev'
require 'custom.keymaps'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
