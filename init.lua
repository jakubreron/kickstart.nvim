require 'custom.plugins.settings.vars'

--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
vim.opt.clipboard = 'unnamedplus'

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

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ float = false })<CR>', { desc = 'Go to previous [d]iagnostic message' })
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next({ float = false })<CR>', { desc = 'Go to next [d]iagnostic message' })
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = '[e]rror Messages' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = '[q]uickfix List' })

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

local function telescope_theme_wrapper(telescope_command, args)
  return function()
    telescope_command(require('telescope.themes').get_ivy { args })
  end
end

require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- Use `opts = {}` to force a plugin to be loaded.
  --  This is equivalent to:
  --    require('Comment').setup({})

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    lazy = false,
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
    keys = {
      {
        '<leader>gl',
        '<cmd>lua require "gitsigns".blame_line()<cr>',
        desc = 'B[l]ame',
      },
      {
        '<leader>gp',
        '<cmd>lua require "gitsigns".preview_hunk()<cr>',
        desc = '[p]review Hunk',
      },
      {
        '<leader>gr',
        '<cmd>lua require "gitsigns".reset_hunk()<cr>',
        desc = '[r]eset Hunk',
      },
      {
        '<leader>gR',
        '<cmd>lua require "gitsigns".reset_buffer()<cr>',
        desc = '[R]eset Buffer',
      },
      {
        '<leader>go',
        '<cmd>Telescope git_status<cr>',
        desc = '[o]pen Changed File',
      },
      {
        '<leader>gc',
        '<cmd>Telescope git_bcommits<cr>',
        desc = '[c]heckout Commit (current file)',
      },
      {
        '<leader>gd',
        '<cmd>Gitsigns diffthis HEAD<cr>',
        desc = '[d]iff',
      },
      {
        ']c',
        '<cmd>lua require"gitsigns".next_hunk({navigation_message = false})<CR>',
        desc = 'Next Git [c]hange',
      },
      {
        '[c',
        '<cmd>lua require"gitsigns".prev_hunk({navigation_message = false})<CR>',
        desc = 'Prev Git [c]hange',
      },
    },
  },

  -- Events can be normal autocommands events (`:help autocmd-events`).
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup {
        -- ignore_missing = true,
        plugins = {
          presets = {
            operators = false, -- adds help for operators like d, y, ...
            motions = false, -- adds help for motions
            text_objects = false, -- help for text objects triggered after entering an operator
            windows = false, -- default bindings on <c-w>
            nav = false, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = false, -- bindings for prefixed with g
          },
        },
        operators = { gc = 'Comments' },
      }

      -- Document existing key chains
      require('which-key').register {
        ['<leader>c'] = { name = '[c]onsole', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[r]eplace', _ = 'which_key_ignore' },
        ['<leader>o'] = { name = '[o]bsession', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[s]earch', _ = 'which_key_ignore' },
        ['<leader>l'] = { name = '[l]SP', _ = 'which_key_ignore' },
        ['<leader>ls'] = { name = '[s]ymbols', _ = 'which_key_ignore' },
        ['<leader>p'] = { name = '[p]ackages', _ = 'which_key_ignore' },
        ['<leader>t'] = { name = '[t]ab', _ = 'which_key_ignore' },
        ['<leader>f'] = { name = '[f]ile', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = 'Vim[w]iki', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[d]iagnostic', _ = 'which_key_ignore' },
        ['<leader>g'] = { name = '[g]it', _ = 'which_key_ignore' },

        ['gc'] = { name = '[c]omment', _ = 'which_key_ignore' },
        ['gb'] = { name = '[b]lock comment', _ = 'which_key_ignore' },
        ['gJ'] = { name = '[J]oin', _ = 'which_key_ignore' },
        ['gS'] = { name = '[S]plit', _ = 'which_key_ignore' },
        ['yo'] = { name = 'T[o]ggle', _ = 'which_key_ignore' },
        ['yos'] = { name = '[s]pelling', _ = 'which_key_ignore' },
      }
    end,
  },

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
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

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ['<c-enter>'] = 'to_fuzzy_refine', -- this is useful

              ['<C-j>'] = require('telescope.actions').cycle_history_next,
              ['<C-k>'] = require('telescope.actions').cycle_history_prev,
            },
          },
          path_display = { 'truncate' },
        },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          live_grep_args = {
            auto_quoting = true,
            mappings = {
              i = {
                ['<C-q>'] = require('telescope-live-grep-args.actions').quote_prompt(),
                ['<C-g>'] = require('telescope-live-grep-args.actions').quote_prompt { postfix = ' --iglob ' },
                ['<C-s>'] = require('telescope-live-grep-args.actions').quote_prompt { postfix = ' --iglob *.spec.*' },
              },
            },
            theme = 'ivy',
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'live_grep_args')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'

      vim.keymap.set('n', '<leader>sh', telescope_theme_wrapper(builtin.help_tags), { desc = '[h]elp' })
      vim.keymap.set('n', '<leader>sk', telescope_theme_wrapper(builtin.keymaps), { desc = '[k]eymaps' })
      vim.keymap.set('n', '<leader>sf', telescope_theme_wrapper(builtin.find_files), { desc = '[f]iles' })
      vim.keymap.set('n', '<leader>ss', telescope_theme_wrapper(builtin.builtin), { desc = '[s]elect Telescope' })
      vim.keymap.set('n', '<leader>sh', telescope_theme_wrapper(builtin.search_history), { desc = '[h]istory' })
      vim.keymap.set('n', '<leader>sw', require('telescope-live-grep-args.shortcuts').grep_word_under_cursor, { desc = '[w]ord' })
      vim.keymap.set('n', '<leader>st', require('telescope').extensions.live_grep_args.live_grep_args, { desc = '[t]ext' })
      vim.keymap.set('n', '<leader>sd', telescope_theme_wrapper(builtin.diagnostics), { desc = '[d]iagnostics' })
      vim.keymap.set('n', '<leader>sl', telescope_theme_wrapper(builtin.resume), { desc = '[l]ast Resume' })
      vim.keymap.set('n', '<leader>sr', telescope_theme_wrapper(builtin.oldfiles), { desc = '[r]ecent Files' })
      vim.keymap.set('n', '<leader>sb', telescope_theme_wrapper(builtin.buffers), { desc = '[b]uffers' })
      vim.keymap.set('n', '<leader>sc', telescope_theme_wrapper(builtin.colorscheme, { enable_preview = true }), { desc = '[c]olorscheme' })
      vim.keymap.set('n', '<leader>sg', telescope_theme_wrapper(builtin.git_files), { desc = '[g]it Files' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        telescope_theme_wrapper(builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        })
      end, { desc = '[/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        telescope_theme_wrapper(builtin.find_files { cwd = vim.fn.stdpath 'config' })
      end, { desc = '[n]eovim files' })
    end,
  },

  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      {
        'williamboman/mason.nvim',
        cmd = { 'Mason', 'MasonInstall', 'MasonUninstall', 'MasonUninstallAll', 'MasonLog' },
        keys = {
          {
            '<leader>lm',
            '<cmd>Mason<CR>',
            desc = '[m]ason',
          },
        },
        event = 'User FileOpened',
        lazy = true,
      },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = '' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', telescope_theme_wrapper(require('telescope.builtin').lsp_definitions), '[d]efinition')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[D]eclaration')

          -- Find references for the word under your cursor.
          map('gr', telescope_theme_wrapper(require('telescope.builtin').lsp_references), '[r]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', telescope_theme_wrapper(require('telescope.builtin').lsp_implementations), '[I]mplementation')

          map('gl', function()
            local float = vim.diagnostic.config().float

            if float then
              local config = type(float) == 'table' and float or {}
              config.scope = 'line'

              vim.diagnostic.open_float(config)
            end
          end, '[l]ine Diagnostics')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>lt', telescope_theme_wrapper(require('telescope.builtin').lsp_type_definitions), '[t]ype Definition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>lsd', telescope_theme_wrapper(require('telescope.builtin').lsp_document_symbols), '[d]ocument')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>lsw', telescope_theme_wrapper(require('telescope.builtin').lsp_dynamic_workspace_symbols), '[w]orkspace')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>lr', vim.lsp.buf.rename, '[r]ename')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>la', vim.lsp.buf.code_action, '[a]ction')

          -- Info about attached servers
          map('<leader>lI', '<cmd>LspInfo<cr>', '[I]nfo')

          -- hover with lsp instead of manpages
          map('K', vim.lsp.buf.hover, '[K] Hover')
          map('H', vim.lsp.buf.signature_help, 'Signature [H]elp')

          map('<leader>l_', '<cmd>LspRestart<cr>', '[_]Restart')

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap.
          -- map('K', vim.lsp.buf.hover, 'Hover Documentation')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
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
        emmet_language_server = {},
        jsonls = {},
        markdown_oxide = {},
        stylelint_lsp = {},
        html = {},
        eslint = {},
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`tsserver`) will work just fine
        -- tsserver = {},
        --

        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
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
      }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        -- NOTE: LSP
        'lua-language-server', -- lua
        'emmet-language-server', -- html
        'json-lsp', -- json
        'markdown-oxide', -- markdown, vimwiki
        'stylelint-lsp', -- styles
        'html-lsp', -- html
        'eslint-lsp', -- js/ts

        -- NOTE: linters
        'htmlhint', -- html
        'stylelint', -- styles

        -- NOTE: formatters
        'stylua', -- lua
        'prettier', -- only json because prettierd is bugged
        'prettierd', -- html, yaml, json, etc

        -- NOTE: 2 in 1, linters & formatters
        'eslint_d', -- js/ts
        'markdownlint', -- markdown, vimwiki
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>ff',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        desc = '[f]ormat buffer',
      },
      {
        '<leader>fF',
        '<cmd>ConformInfo<cr>',
        desc = '[F]ormatters attached',
      },
    },
    config = function()
      local prettier_paths = { 'singularity' }
      local js_ts_formatters = {}

      for i = 1, #prettier_paths do
        if string.find(vim.fn.expand '%:p:h', prettier_paths[i]) then
          js_ts_formatters = { { 'prettierd' } }
        else
          js_ts_formatters = { { 'eslint_d' } }
        end
      end

      require('conform').setup {
        notify_on_error = false,
        format_on_save = function(bufnr)
          -- Disable "format_on_save lsp_fallback" for languages that don't
          -- have a well standardized coding style. You can add additional
          -- languages here or re-enable it for the disabled ones.
          local disable_filetypes = { c = true, cpp = true }

          if disable_filetypes[vim.bo[bufnr].filetype] then
            return false
          end

          return {
            timeout_ms = 500,
            lsp_fallback = true,
          }
        end,
        formatters_by_ft = {
          lua = { 'stylua' },
          -- Conform can also run multiple formatters sequentially
          -- python = { "isort", "black" },
          --
          -- You can use a sub-list to tell conform to run *until* a formatter
          -- is found.

          -- NOTE: RFB = eslint_d,
          -- NOTE: Singularity = prettierd

          javascript = js_ts_formatters,
          javascriptreact = js_ts_formatters,
          vue = js_ts_formatters,
          typescript = js_ts_formatters,
          typescriptreact = js_ts_formatters,

          -- javascript = { { 'eslint_d' } },
          -- javascriptreact = { { 'eslint_d' } },
          -- vue = { { 'eslint_d' } },
          -- typescript = { { 'eslint_d' } },
          -- typescriptreact = { { 'eslint_d' } },

          -- javascript = { { 'prettierd' } },
          -- javascriptreact = { { 'prettierd' } },
          -- vue = { { 'prettierd' } },
          -- typescript = { { 'prettierd' } },
          -- typescriptreact = { { 'prettierd' } },

          css = { { 'prettierd' } },
          scss = { { 'prettierd' } },
          less = { { 'prettierd' } },
          sass = { { 'prettierd' } },

          markdown = { { 'markdownlint' } },
          vimwiki = { { 'markdownlint' } },

          html = { { 'prettierd' } },
          yaml = { { 'prettierd' } },
          json = { { 'prettier' } }, -- NOTE: nice to have prettierd, but it creates bugs in japanese characters
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
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
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

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

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

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
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
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'buffer' },
        },
      }
    end,
  },

  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    opts = {
      transparent_background = true,
    },
    init = function()
      vim.cmd.colorscheme 'catppuccin-mocha'
      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },

  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
    config = function()
      vim.keymap.set('n', ']t', function()
        require('todo-comments').jump_next()
      end, { desc = 'Next [t]odo comment' })

      vim.keymap.set('n', '[t', function()
        require('todo-comments').jump_prev()
      end, { desc = 'Previous [t]odo comment' })

      vim.keymap.set('n', '<leader>T', '<cmd>TodoTelescope<cr>', { desc = '[T]odos' })
    end,
  },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      --  - dil{  - [D]elete [I]nside [L]ast [{]
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      -- require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      -- local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      -- statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      -- statusline.section_location = function()
      --   return '%2l:%-2v'
      -- end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter-context',
        opts = {
          max_lines = 5, -- How many lines the window should span. Values
        },
      }, -- sticky scroll context

      -- { "nvim-treesitter/nvim-treesitter-textobjects" }, -- more movements (if, af, ic, ac, etc...)
    },
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'vim',
        'vimdoc',
        'tsx',
        'typescript',
        'javascript',
        'css',
        'scss',
        'vue',
        'json',
        'yaml',
        'toml',
        'hyprlang',
        'regex',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
        config = {
          -- Languages that have a single comment style
          typescript = '// %s',
          css = '/* %s */',
          scss = '/* %s */',
          html = '<!-- %s -->',
          svelte = '<!-- %s -->',
          vue = '<!-- %s -->',
          json = '',
        },
      },
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      -- require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },

  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  -- --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',

  -- require 'kickstart.plugins.lint',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {},
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

require 'custom.settings'
require 'custom.autocmds'
require 'custom.iabbrev'
require 'custom.keymaps'
