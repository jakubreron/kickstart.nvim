--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.monorepo_name = 'singularity'

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- disable native complete with C-n, C-p
vim.opt.cpt = ''

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.breakindent = true

vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

vim.opt.cursorline = true

vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5

vim.opt.swapfile = false

vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited

vim.opt.spelllang:append 'cjk' -- disable spellchecking for asian characters (VIM algorithm does not support it)

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

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
  callback = function()
    vim.highlight.on_yank()
  end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- statuscolumn = { enabled = true },
      lazygit = { enabled = true },
      picker = {
        matcher = {
          frecency = true,
          history_bonus = true,
        },
        win = {
          input = {
            keys = {
              ['<C-u>'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
              ['<C-d>'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
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
        function()
          Snacks.picker.buffers()
        end,
        desc = '[b]uffers',
      },
      {
        '<leader>sf',
        function()
          Snacks.picker.smart()
        end,
        desc = '[f]iles',
      },
      {
        '<leader>sd',
        function()
          Snacks.picker.diagnostics()
        end,
        desc = '[d]iagnostic',
      },
      {
        '<leader>svh',
        function()
          Snacks.picker.help()
        end,
        desc = '[h]elp',
      },
      {
        '<leader>svc',
        function()
          Snacks.picker.colorschemes()
        end,
        desc = '[c]olorscheme',
      },
      {
        '<leader>svk',
        function()
          Snacks.picker.keymaps()
        end,
        desc = '[k]eymaps',
      },
      {
        '<leader>st',
        function()
          Snacks.picker.grep()
        end,
        desc = '[t]ext',
      },
      {
        '<leader>sp',
        function()
          Snacks.picker.projects()
        end,
        desc = '[p]rojects',
      },
      {
        '<leader>sgf',
        function()
          Snacks.picker.git_status()
        end,
        desc = '[f]iles (changed)',
      },
      {
        '<leader>sgb',
        function()
          Snacks.picker.git_branches()
        end,
        desc = '[b]ranches',
      },
      {
        '<leader>sgla',
        function()
          Snacks.picker.git_log()
        end,
        desc = '[a]ll',
      },
      {
        '<leader>sgll',
        function()
          Snacks.picker.git_log_line()
        end,
        desc = '[l]ine',
      },
      {
        '<leader>sglf',
        function()
          Snacks.picker.git_log_file()
        end,
        desc = '[f]ile',
      },
      {
        '<leader>sl',
        function()
          Snacks.picker.resume()
        end,
        desc = '[l]ast resume',
      },
      {
        'gd',
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = '[d]efinition',
      },
      {
        'gy',
        function()
          Snacks.picker.lsp_type_definitions()
        end,
        desc = 't[y]pe definition',
      },
      {
        'gD',
        function()
          Snacks.picker.lsp_declarations()
        end,
        desc = '[D]eclaration',
      },
      {
        'gr',
        function()
          Snacks.picker.lsp_references()
        end,
        desc = '[r]eferences',
        nowait = true,
      },
      {
        'gI',
        function()
          Snacks.picker.lsp_implementations()
        end,
        desc = '[i]mplementation',
      },
      {
        '<leader>gg',
        function()
          Snacks.lazygit()
        end,
        desc = 'lazy[g]it',
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'williamboman/mason.nvim',
        config = true,
        keys = {
          {
            '<leader>lm',
            '<cmd>Mason<cr>',
            desc = '[m]ason',
          },
        },
      }, -- NOTE: Must be loaded before dependants

      { 'williamboman/mason-lspconfig.nvim' },
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },

      {
        'saghen/blink.cmp',
        dependencies = {
          'rafamadriz/friendly-snippets',
        },
        version = '*',
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
          keymap = { preset = 'default' },
          appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono',
          },
          sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
          },
          completion = {
            documentation = {
              auto_show = true,
              auto_show_delay_ms = 0,
            },
          },
          signature = { enabled = true },
        },
        opts_extend = { 'sources.default' },
      },

      {
        'j-hui/fidget.nvim',
        config = true,
      },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
          end

          map('<leader>lr', vim.lsp.buf.rename, '[r]ename')
          map('<leader>la', vim.lsp.buf.code_action, '[a]ction', { 'n', 'x' })

          map('H', vim.lsp.buf.signature_help, 'signature [H]elp')

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end
        end,
      })

      local signs = { Error = '', Warn = '', Hint = '', Info = '' }
      for type, icon in pairs(signs) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      local servers = {
        lua_ls = {
          server_capabilities = {
            semanticTokensProvider = vim.NIL,
          },
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
        intelephense = {
          settings = {
            intelephense = {
              stubs = {
                'bcmath',
                'bz2',
                'calendar',
                'Core',
                'curl',
                'date',
                'dba',
                'dom',
                'enchant',
                'fileinfo',
                'filter',
                'ftp',
                'gd',
                'gettext',
                'hash',
                'iconv',
                'imap',
                'intl',
                'json',
                'ldap',
                'libxml',
                'mbstring',
                'mcrypt',
                'mysql',
                'mysqli',
                'password',
                'pcntl',
                'pcre',
                'PDO',
                'pdo_mysql',
                'Phar',
                'readline',
                'recode',
                'Reflection',
                'regex',
                'session',
                'SimpleXML',
                'soap',
                'sockets',
                'sodium',
                'SPL',
                'standard',
                'superglobals',
                'sysvsem',
                'sysvshm',
                'tokenizer',
                'xml',
                'xdebug',
                'xmlreader',
                'xmlwriter',
                'yaml',
                'zip',
                'zlib',
                'wordpress',
                'woocommerce',
                'acf-pro',
                'acf-stubs',
                'wordpress-globals',
                'wp-cli',
                'genesis',
                'polylang',
                'sbi',
              },
              diagnostics = { enable = true },
              files = {
                maxSize = 10000000,
              },
            },
          },
        },
        -- ts_ls = {
        --   root_dir = require('lspconfig.util').root_pattern('package.json', '.git'),
        --   server_capabilities = {
        --     documentFormattingProvider = false,
        --   },
        -- },
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        -- NOTE: LSP
        'lua-language-server',
        'typescript-language-server',
        'emmet-language-server',
        'bash-language-server',
        'json-lsp',
        'markdown-oxide', -- markdown, vimwiki
        'stylelint-lsp',
        'html-lsp',
        'css-lsp',
        'eslint-lsp',
        'intelephense',
        'gopls',
        'sqls',

        -- NOTE: linters
        -- ''

        -- NOTE: formatters
        'stylua',
        'prettier', -- only json because prettierd is bugged
        'prettierd', -- html, yaml, json, etc

        -- NOTE: 2 in 1, linters & formatters
        'markdownlint', -- markdown, vimwiki
      })

      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            if server_name == 'ts_ls' then
              return
            end

            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = true,
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>ff',
        function()
          require('conform').format { async = true, lsp_format = 'never' }
        end,
        desc = '[f]ormat buffer',
      },
      {
        '<leader>fa',
        '<cmd>ConformInfo<cr>',
        desc = '[a]ttached formatters',
      },
    },
    config = function()
      -- eslint-lsp is not a formatter, so we cannot return it, but it provides a command for formatting,
      local prettier_paths = { vim.g.monorepo_name }

      local js_ts_formatters_callback = function(bufnr)
        local buf_modified = vim.api.nvim_get_option_value('modified', { buf = bufnr })

        if buf_modified then
          vim.cmd 'silent! EslintFixAll'
        end

        for i = 1, #prettier_paths do
          if string.find(vim.api.nvim_buf_get_name(bufnr), prettier_paths[i]) then
            return { 'prettierd' }
          end

          return {}
        end
      end

      require('conform').setup {
        notify_on_error = false,
        format_on_save = function(bufnr)
          return {
            timeout_ms = 500,
            lsp_format = 'never',
          }
        end,
        formatters_by_ft = {
          lua = { 'stylua' },

          javascript = js_ts_formatters_callback,
          javascriptreact = js_ts_formatters_callback,
          vue = js_ts_formatters_callback,
          typescript = js_ts_formatters_callback,
          typescriptreact = js_ts_formatters_callback,

          css = { 'prettierd' },
          scss = { 'prettierd' },
          less = { 'prettierd' },
          sass = { 'prettierd' },

          markdown = { 'markdownlint' },
          vimwiki = { 'markdownlint' },

          html = { 'prettierd' },
          php = { 'prettier' },
          yaml = { 'prettierd' },
          json = { 'prettier' }, -- NOTE: nice to have prettierd, but it creates bugs in japanese characters
        },
      }
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    opts = {
      ensure_installed = {
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
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
  },

  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  { import = 'custom.plugins' },
}

require 'custom.autocmds'
require 'custom.iabbrev'
require 'custom.keymaps'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
