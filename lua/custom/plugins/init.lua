return {
  'tpope/vim-repeat', -- better "."
  'tpope/vim-unimpaired', -- additional mappings
  'AndrewRadev/splitjoin.vim',

  {
    'kevinhwang91/nvim-bqf',
    lazy = true,
    event = 'QuickFixCmdPre',
    ft = 'qf',
    keys = {
      '<C-q>',
    },
  },

  {
    'nat-418/boole.nvim',
    lazy = true,
    config = {
      mappings = {
        increment = '<C-a>',
        decrement = '<C-x>',
      },
      -- User defined loops
      additions = {
        -- { 'Foo', 'Bar', ' },
        -- { 'tic', 'tac', 'toe' },
      },
      allow_caps_additions = {
        { 'enable', 'disable' },
        -- enable → disable
        -- Enable → Disable
        -- ENABLE → DISABLE
      },
    },
    keys = {
      '<C-a>',
      '<C-x>',
    },
  },

  {
    'sangdol/mintabline.vim', -- tabs with numbers & icons
    lazy = true,
    event = 'TabEnter',
  },

  {
    'tpope/vim-surround', -- surround movement
    lazy = true,
    keys = {
      'ys',
      'ds',
      'cs',
      {
        'S',
        mode = 'v',
      },
    },
  },

  {
    'vimwiki/vimwiki',
    lazy = true,
    cmd = { 'VimwikiIndex', 'VimwikiDiaryIndex' },
    event = 'BufWinEnter ' .. vim.fn.expand '$VIMWIKI_DIR' .. '/*',
    keys = {
      '<leader>w',
    },
  },

  {
    'christoomey/vim-titlecase', -- "gz" movement to toggle the words case
    lazy = true,
    keys = {
      'gz',
      'gzz',
    },
  },

  -- {
  --   'szw/vim-maximizer', -- maximize current window
  --   lazy = true,
  --   cmd = { 'MaximizerToggle' },
  --   keys = {
  --     {
  --       '<leader>m',
  --       '<cmd>MaximizerToggle!<cr>',
  --       desc = '[m]aximize',
  --     },
  --   },
  -- },

  {
    'hedyhli/outline.nvim',
    lazy = true,
    cmd = { 'Outline', 'OutlineOpen' },
    keys = {
      {
        '<leader>fo',
        '<cmd>Outline<cr>',
        desc = '[o]utline',
      },
    },
    config = true,
  },

  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
        key = function()
          return vim.loop.cwd()
        end,
      },
    },
  },

  {
    'christoomey/vim-tmux-navigator', -- tmux navigation from within nvim
    lazy = true,
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },

  {
    'tpope/vim-obsession', -- save the session
    lazy = false, -- do not lazyload it since it can be pre-enabled with nvim -S
    cmd = { 'Obsession' },
    keys = {
      { '<leader>ot', '<cmd>Obsession<cr>', desc = '[t]rack session' },
      { '<leader>oT', ':Obsession Session-.vim<Left><Left><Left><Left>', desc = '[T]rack custom session' },
      { '<leader>os', '<cmd>source Session.vim<cr>', desc = '[s]ource session' },
      { '<leader>oS', ':source Session-', desc = '[S]ource custom session' },
    },
  },

  {
    'nvim-neotest/neotest', -- run tests directly from the file
    lazy = true,
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      {
        'haydenmeade/neotest-jest',
        event = 'BufWinEnter *.spec.*',
      },
    },
    version = '5.1.0',
    config = function()
      require('custom.plugins.settings.neotest').config()
    end,
    event = 'BufWinEnter *.spec.*',
  },

  -- {
  --   'norcalli/nvim-colorizer.lua', -- highlight the hex / rgb colors
  --   lazy = true,
  --   config = function()
  --     require('custom.plugins.settings.colorizer').config()
  --   end,
  --   ft = {
  --     'css',
  --     'scss',
  --   },
  -- },

  {
    'windwp/nvim-spectre', -- search & replace throughout all the files (without vimgrepping)
    lazy = true,
    keys = {
      {
        '<leader>ra',
        '<cmd>lua require("spectre").open()<cr>',
        desc = '[a]ll',
      },
      {
        '<leader>rw',
        '<cmd>lua require("spectre").open_visual({select_word=true})<cr>',
        desc = '[w]ord',
      },
    },
  },

  {
    'vuki656/package-info.nvim', -- check if the package info is up to date
    lazy = true,
    dependencies = 'MunifTanjim/nui.nvim',
    event = 'BufWinEnter package.json',
    config = true,
  },

  {
    'pmizio/typescript-tools.nvim',
    lazy = true,
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    ft = {
      'javascript',
      'typescript',
      'typescriptreact',
    },
    config = true,
  },

  -- co — choose ours
  -- ct — choose theirs
  -- cb — choose both
  -- c0 — choose none
  -- ]x — move to previous conflict
  -- [x — move to next conflict
  {
    'akinsho/git-conflict.nvim',
    version = '*',
    config = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'GitConflictDetected',
        callback = function()
          vim.keymap.set('n', '<C-q>', '<cmd>GitConflictListQf<cr>', { desc = 'Conflicts quicklist' })
          vim.notify('Conflict detected in ' .. vim.fn.expand '<afile>')
          require('conform').setup { format_on_save = false }
        end,
      })

      vim.api.nvim_create_autocmd('User', {
        pattern = 'GitConflictResolved',
        callback = function()
          vim.keymap.set('n', '<C-q>', '<C-v>')
          vim.notify('Conflict resolved in ' .. vim.fn.expand '<afile>')
          require('conform').setup {
            format_on_save = {
              timeout_ms = 500,
              lsp_fallback = false,
            },
          }
        end,
      })

      require('git-conflict').setup {
        default_mappings = true, -- disable buffer local mapping created by this plugin
        default_commands = true, -- disable commands created by this plugin
        disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
        list_opener = 'copen', -- command or function to open the conflicts list
        highlights = { -- They must have background color, otherwise the default color will be used
          incoming = 'DiffAdd',
          current = 'DiffText',
        },
      }
    end,
  },

  {
    'ramilito/winbar.nvim',
    event = 'BufReadPre', -- Alternatively, BufReadPre if we don't care about the empty file when starting with 'nvim'
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('winbar').setup {
        -- your configuration comes here, for example:
        icons = true,
        diagnostics = true,
        buf_modified = true,
      }
    end,
  },

  {
    'stevearc/oil.nvim',
    lazy = true,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup {
        columns = {
          'icon',
          'size',
        },
        keymaps = {
          ['<C-h>'] = false,
          ['<C-v>'] = require('oil.actions').select_vsplit,
          ['<C-s>'] = false,
          ['<C-x>'] = require('oil.actions').select_split,
        },
        view_options = {
          show_hidden = true,
        },
      }
    end,
    keys = {
      {
        '-',
        '<cmd>Oil<cr>',
        desc = '[-] explorer',
      },
      {
        '<leader>-',
        '<cmd>Oil<cr>',
        desc = '[-] explorer (floating window)',
      },
    },
  },

  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = true,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('custom.plugins.settings.nvimtree').config()
    end,
    keys = {
      {
        '<leader>e',
        '<cmd>NvimTreeToggle<cr>',
        desc = '[e]xplorer',
      },
    },
    cmd = { 'NvimTreeToggle', 'NvimTreeOpen', 'NvimTreeFocus', 'NvimTreeFindFileToggle' },
    event = 'User DirOpened',
  },

  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('custom.plugins.settings.lualine').config()
    end,
    event = 'VimEnter',
  },

  {
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    keys = {
      { '<leader>gg', '<cmd>LazyGitCurrentFile<cr>', desc = 'lazy[g]it' },
      { '<leader>gs', '<cmd>lua require("telescope").extensions.lazygit.lazygit()<cr>', desc = 'lazygit [s]earch' },
      -- { '<leader>gc', '<cmd>LazyGitFilterCurrentFile<cr>', desc = '[c]heckout commit (current file)' },
      -- { '<leader>gC', '<cmd>LazyGitFilter<cr>', desc = '[C]heckout commit' },
    },
    config = function()
      require('telescope').load_extension 'lazygit'
    end,
  },

  -- {
  --   'folke/tokyonight.nvim',
  --   priority = 1000, -- Make sure to load this before all the other start plugins.
  --   config = function()
  --     require('tokyonight').setup {
  --       -- your configuration comes here
  --       -- or leave it empty to use the default settings
  --       style = 'storm', -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  --       transparent = true, -- Enable this to disable setting the background color
  --       terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  --       styles = {
  --         -- Style to be applied to different syntax groups
  --         -- Value is any valid attr-list value for `:help nvim_set_hl`
  --         comments = { italic = false },
  --         keywords = { italic = false },
  --         -- Background styles. Can be "dark", "transparent" or "normal"
  --         sidebars = 'dark', -- style for sidebars, see below
  --         floats = 'dark', -- style for floating windows
  --       },
  --     }
  --   end,
  --   init = function()
  --     vim.cmd.colorscheme 'tokyonight'
  --   end,
  -- },
}
