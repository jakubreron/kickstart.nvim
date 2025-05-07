--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.monorepo_name = 'singularity'
vim.g.vimwiki_list = {
  {
    path = vim.fn.expand '$VIMWIKI_DIR',
    syntax = 'markdown',
    ext = '.md',
  },
}

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.smartindent = true

vim.opt.winborder = 'rounded'

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = 'a'

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
-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true

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
      git = { enabled = true },
      picker = {
        hidden = true,
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
        '<leader>sl',
        function()
          Snacks.picker.resume()
        end,
        desc = '[l]ast resume',
      },
      {
        '<leader>su',
        function()
          Snacks.picker.undo()
        end,
        desc = '[u]ndo',
      },
      {
        'grd',
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = '[d]efinition',
      },
      {
        'grt',
        function()
          Snacks.picker.lsp_type_definitions()
        end,
        desc = '[t]ype definition',
      },
      {
        'grD',
        function()
          Snacks.picker.lsp_declarations()
        end,
        desc = '[D]eclaration',
      },
      {
        'grr',
        function()
          Snacks.picker.lsp_references()
        end,
        desc = '[r]eferences',
        nowait = true,
      },
      {
        'gri',
        function()
          Snacks.picker.lsp_implementations()
        end,
        desc = '[i]mplementation',
      },
      {
        'g0',
        function()
          Snacks.picker.lsp_symbols()
        end,
        desc = 'LSP Symbols',
      },
      {
        '<leader>gg',
        function()
          Snacks.lazygit()
        end,
        desc = 'lazy[g]it',
      },
      {
        '<leader>gb',
        function()
          Snacks.git.blame_line()
        end,
        desc = '[b]lame line',
      },
      {
        '<leader>gc',
        function()
          Snacks.picker.git_status()
        end,
        desc = '[c]hanged files',
      },
      {
        '<leader>gB',
        function()
          Snacks.picker.git_branches()
        end,
        desc = '[B]ranches',
      },
      {
        '<leader>gd',
        function()
          Snacks.picker.git_diff()
        end,
        desc = '[d]iff',
      },
      {
        '<leader>gla',
        function()
          Snacks.picker.git_log()
        end,
        desc = '[a]ll',
      },
      {
        '<leader>gll',
        function()
          Snacks.picker.git_log_line()
        end,
        desc = '[l]ine',
      },
      {
        '<leader>glf',
        function()
          Snacks.picker.git_log_file()
        end,
        desc = '[f]ile',
      },

      {
        '<C-q>',
        function()
          Snacks.picker.qflist()
        end,
        desc = '[q]uickfix',
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
            default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
            providers = {
              lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
            },
          },
          cmdline = {
            completion = {
              menu = { auto_show = true },
            },
          },
          completion = {
            menu = {
              border = 'single',
            },
            documentation = {
              auto_show = true,
              auto_show_delay_ms = 0,
              window = {
                border = 'single',
              },
            },
          },
          signature = {
            enabled = true,
            window = {
              border = 'single',
            },
          },
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
        ts_ls = {
          server_capabilities = {
            documentFormattingProvider = false,
          },
        },
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

      require('mason-lspconfig').setup {
        automatic_enable = {
          exclude = {
            'ts_ls',
          },
        },
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        handlers = {
          function(server_name)
            local config = servers[server_name] or {}

            vim.lsp.config(server_name, config)
            vim.lsp.enable(server_name)
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
        '<leader>lf',
        function()
          require('conform').format { async = true, lsp_format = 'never' }
        end,
        desc = '[f]ormat buffer',
      },
    },
    config = function()
      -- WARNING: eslint-lsp is not a formatter, so we cannot return it, but it provides a command for formatting,
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
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  { import = 'custom.plugins' },
  { import = 'custom.colorscheme' },
}

require 'custom.autocmds'
require 'custom.iabbrev'
require 'custom.keymaps'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
