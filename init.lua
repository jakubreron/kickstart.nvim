require 'custom.plugins.settings.vars'

--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true
vim.g.monorepo_name = 'singularity'

vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- disable native complete with C-n, C-p
vim.opt.cpt = ''

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = '[q]uickfix List' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'move focus to the upper window' })

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

require('lazy').setup({
  -- Use `opts = {}` to force a plugin to be loaded.
  -- `opts = {}` is the same as calling `require('plugin').setup({})`
  -- with the `config` key, the configuration only runs after the plugin has been loaded:
  -- config = function() ... end
  {
    'folke/which-key.nvim',
    lazy = true,
    keys = { '<leader>', '<c-r>', '"', "'", '`', 'c', 'v', 'g' },
    opts = {
      plugins = {
        presets = {
          operators = false, -- adds help for operators like d, y, ...
          motions = false, -- adds help for motions
          text_objects = false, -- help for text objects triggered after entering an operator
          nav = false, -- misc bindings to work with windows
          z = true, -- bindings for folds, spelling and others prefixed with z
          g = false, -- bindings for prefixed with g
        },
      },
      icons = {
        mappings = vim.g.have_nerd_font,
      },
      win = {
        border = 'single',
      },
      spec = {
        { '<leader>g', desc = '[g]it', mode = { 'v', 'n' }, icon = '' },
        { '<leader>c', desc = '[c]onsole', icon = '' },
        { '<leader>r', desc = '[r]eplace', icon = '󰛔' },
        { '<leader>o', desc = '[o]bsession', icon = '' },
        { '<leader>l', desc = '[l]sp', icon = '' },
        { '<leader>l_', desc = '[_]actions', icon = '' },
        { '<leader>p', desc = '[p]ackages', icon = '' },
        { '<leader>t', desc = '[t]ab', icon = '󰓩' },
        { '<leader>f', desc = '[f]ile', icon = '' },
        { '<leader>w', desc = 'vim[w]iki', icon = '󰖬' },
        { '<leader>d', desc = '[d]iagnostic', icon = '' },

        { '<leader>s', desc = '[s]earch', icon = '' },
        { '<leader>sv', desc = '[v]im', icon = '' },
        { '<leader>sg', desc = '[g]it', icon = '' },
      },
    },
  },

  {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    event = 'VeryLazy',
    branch = 'master',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-telescope/telescope-live-grep-args.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require 'custom.plugins.settings.telescope'

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'live_grep_args')

      local builtin = require 'telescope.builtin'

      -- NOTE: vim
      vim.keymap.set('n', '<leader>svh', builtin.help_tags, { desc = '[h]elp' })
      vim.keymap.set('n', '<leader>svk', builtin.keymaps, { desc = '[k]eymaps' })
      vim.keymap.set('n', '<leader>svc', function()
        builtin.colorscheme { enable_preview = true }
      end, { desc = '[c]olorscheme' })
      vim.keymap.set('n', '<leader>svn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[n]eovim files' })

      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[f]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[s]elect telescope' })
      vim.keymap.set('n', '<leader>sh', builtin.search_history, { desc = '[h]istory' })
      vim.keymap.set('n', '<leader>sw', require('telescope-live-grep-args.shortcuts').grep_word_under_cursor, { desc = '[w]ord' })
      vim.keymap.set('n', '<leader>st', require('telescope').extensions.live_grep_args.live_grep_args, { desc = '[t]ext' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[d]iagnostics' })
      vim.keymap.set('n', '<leader>sl', builtin.resume, { desc = '[l]ast resume' })
      vim.keymap.set('n', '<leader>sr', builtin.oldfiles, { desc = '[r]ecent files' })
      vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[b]uffers' })
      vim.keymap.set('n', '<leader>su', builtin.grep_string, { desc = 'word [u]nder string' })

      -- NOTE: git
      vim.keymap.set('n', '<leader>sgf', builtin.git_status, { desc = '[f]iles (changed)' })
      vim.keymap.set('n', '<leader>sgc', builtin.git_bcommits, { desc = '[c]ommit (current file)' })
      vim.keymap.set('n', '<leader>sgC', builtin.git_commits, { desc = '[C]ommit (all files)' })
      vim.keymap.set('n', '<leader>sgb', builtin.git_branches, { desc = '[b]ranch' })
      vim.keymap.set('n', '<leader>sgs', builtin.git_stash, { desc = '[s]tash' })

      vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = '[/] fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[/] in open files' })
    end,
  },

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      {
        'williamboman/mason.nvim',
        cmd = { 'Mason', 'MasonInstall', 'MasonUninstall', 'MasonUninstallAll', 'MasonLog' },
        keys = {
          {
            '<leader>lm',
            '<cmd>Mason<cr>',
            desc = '[m]ason',
          },
        },
        event = 'User FileOpened',
        lazy = true,
        config = true,
      }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      {
        'j-hui/fidget.nvim',
        config = true,
        opts = {
          notification = {
            window = {
              border = 'rounded',
              x_padding = 0,
              y_padding = 0,
            },
          },
        },
      },

      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      require('lspconfig.ui.windows').default_options.border = 'rounded'

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
          end

          local builtin = require 'telescope.builtin'

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', builtin.lsp_definitions, '[d]efinition')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[D]eclaration')

          -- Find references for the word under your cursor.
          map('gr', builtin.lsp_references, '[r]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', builtin.lsp_implementations, '[I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>lt', builtin.lsp_type_definitions, '[t]ype Definition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ls', builtin.lsp_document_symbols, '[s]ymbols (file)')
          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>lS', builtin.lsp_dynamic_workspace_symbols, '[S]ymbols (workspace)')

          map('<leader>lr', vim.lsp.buf.rename, '[r]ename')
          map('<leader>la', vim.lsp.buf.code_action, '[a]ction', { 'n', 'x' })

          map('<leader>l_i', '<cmd>LspInfo<cr>', '[i]nfo')
          map('<leader>l_r', '<cmd>LspRestart<cr>', '[r]estart')

          -- hover with lsp instead of manpages
          map('H', vim.lsp.buf.signature_help, 'signature [H]elp')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
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

          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>lh', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, 'inlay [h]ints toggle')
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
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
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
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

      -- Ensure the servers and tools above are installed
      require('mason').setup {
        ui = {
          border = 'rounded',
        },
      }

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        -- NOTE: LSP
        'lua-language-server',
        'typescript-language-server',
        'emmet-language-server',
        'json-lsp',
        'markdown-oxide', -- markdown, vimwiki
        'stylelint-lsp',
        'html-lsp',
        'css-lsp',
        -- 'css_variables',
        'eslint-lsp',

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

      -- vim.api.nvim_create_autocmd('BufWritePre', {
      --   pattern = { '*.tsx', '*.ts', '*.jsx', '*.js', '*.vue' },
      --   command = 'silent! EslintFixAll',
      --   group = vim.api.nvim_create_augroup('MyAutocmdsJavaScripFormatting', {}),
      -- })

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)

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
          -- Conform can also run multiple formatters sequentially
          -- python = { "isort", "black" },
          --
          -- You can use a sub-list to tell conform to run *until* a formatter
          -- is found.

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
          yaml = { 'prettierd' },
          json = { 'prettier' }, -- NOTE: nice to have prettierd, but it creates bugs in japanese characters
        },
      }
    end,
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      local completeopt = 'menu,menuone,noinsert,preview'

      vim.opt.completeopt = completeopt
      vim.opt.pumheight = 20 -- completion menu height

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = completeopt },

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-u>'] = cmp.mapping.scroll_docs(4),

          ['<C-y>'] = cmp.mapping.confirm { select = true },

          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          {
            name = 'lazydev',
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'buffer' },
        },
      }

      for _, ft_path in ipairs(vim.api.nvim_get_runtime_file('lua/custom/snippets/*.lua', true)) do
        loadfile(ft_path)()
      end
    end,
  },

  {
    'echasnovski/mini.nvim',
    lazy = true,
    event = 'VeryLazy',
    config = function()
      require 'custom.plugins.settings.mini'
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter-context',
        opts = {
          max_lines = 4, -- How many lines the window should span. Values
        },
      }, -- sticky scroll context

      -- { "nvim-treesitter/nvim-treesitter-textobjects" }, -- more movements (if, af, ic, ac, etc...)
    },
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
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
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        -- additional_vim_regex_highlighting = { 'ruby' },
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },

  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',

  -- require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  { import = 'custom.plugins' },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {},
    border = 'rounded',
  },
})

require 'custom.settings'
require 'custom.autocmds'
require 'custom.iabbrev'
require 'custom.keymaps'
require 'custom.keymaps.autogenerated'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
