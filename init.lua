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

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.smartindent = true
vim.o.winborder = 'rounded'
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.complete = ''
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)
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
  callback = function()
    vim.hl.on_yank()
  end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require('lazy').setup {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    ---@module 'lazydev'
    ---@type lazydev.Config
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = 'snacks.nvim', words = { 'Snacks' } },
      },
    },
  },

  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@module 'snacks'
    ---@type snacks.Config
    ---@diagnostic disable-next-line: missing-fields
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
      { -- NOTE: Must be loaded before dependants
        'mason-org/mason.nvim',
        config = true,
      },

      { 'mason-org/mason-lspconfig.nvim' },
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
          appearance = {
            use_nvim_cmp_as_default = true,
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
            documentation = {
              auto_show = true,
              auto_show_delay_ms = 0,
            },
          },
        },
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
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer, here it works only with LSPs, not with formatters/linters)
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
          require('conform').format { lsp_format = 'prefer' }
        end,
        desc = '[f]ormat buffer',
      },
    },
    -- This will provide type hinting with LuaLS
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      format_on_save = { lsp_format = 'prefer' },
      formatters_by_ft = {
        lua = { 'stylua' },

        javascript = { 'prettierd' },
        javascriptreact = { 'prettierd' },
        vue = { 'prettierd' },
        typescript = { 'prettierd' },
        typescriptreact = { 'prettierd' },

        css = { 'prettierd' },
        scss = { 'prettierd' },
        less = { 'prettierd' },
        sass = { 'prettierd' },
        html = { 'prettierd' },
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
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    ---@module 'nvim-treesitter.configs'
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
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
