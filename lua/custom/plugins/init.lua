return {
  { 'vimwiki/vimwiki' },

  { 'sangdol/mintabline.vim' }, -- tabs with numbers & icons

  { 'AndrewRadev/splitjoin.vim' }, -- gJ, gS movements

  -- TODO: refactor the keys like in vim-maximizer/outline
  {
    'szw/vim-maximizer',
    lazy = true,
    cmd = { 'MaximizerToggle' },
    keys = {
      {
        '<leader><leader>',
        '<cmd>MaximizerToggle!<CR>',
        desc = 'Maximize',
      },
    },
  }, -- maximize current window

  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
  },

  {
    'hedyhli/outline.nvim',
    lazy = true,
    cmd = { 'Outline', 'OutlineOpen' },
    keys = {
      {
        '<leader>lfo',
        '<cmd>Outline<CR>',
        desc = 'Toggle outline',
      },
    },
  },

  {
    'stevearc/dressing.nvim',
  }, -- better default nvim interfaces

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
    'letieu/harpoon-lualine',
    dependencies = {
      {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
      },
    },
  },

  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = {
      max_lines = 5, -- How many lines the window should span. Values
    },
  }, -- sticky scroll context
  -- { "nvim-treesitter/nvim-treesitter-textobjects" }, -- more movements (if, af, ic, ac, etc...)

  { 'christoomey/vim-titlecase' }, -- "gz" movement to toggle the words case

  {
    'christoomey/vim-tmux-navigator',
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
  }, -- tmux navigation from within nvim

  { 'tpope/vim-repeat' }, -- better "."
  { 'tpope/vim-surround' }, -- surround movement
  { 'tpope/vim-obsession' }, -- save the session
  { 'tpope/vim-unimpaired' }, -- additional mappings

  {
    'nvim-neotest/neotest', -- run tests directly from the file
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('user.plugins.settings.neotest').config()
    end,
    event = 'BufWinEnter *.spec.*',
    lazy = true,
  },
  {
    'haydenmeade/neotest-jest',
    pin = true,
    commit = 'c2118446d770fedb360a91b1d91a7025db86d4f1',
  },

  {
    'norcalli/nvim-colorizer.lua', -- highlight the hex / rgb colors
    config = function()
      require('user.plugins.settings.colorizer').config()
    end,
    ft = {
      'css',
      'scss',
    },
    lazy = true,
  },

  {
    'windwp/nvim-spectre', -- search & replace throughout all the files (without vimgrepping)
    event = 'BufRead',
    config = true,
    lazy = true,
  },

  {
    'vuki656/package-info.nvim', -- check if the package info is up to date
    dependencies = 'MunifTanjim/nui.nvim',
    event = 'BufWinEnter package.json',
    config = true,
    lazy = true,
  },

  {
    'kevinhwang91/nvim-bqf', -- better quickfix window (preview, search & replace, etc...)
    event = { 'BufRead', 'BufNew' },
    config = true,
    lazy = true,
  },

  {
    'nvim-telescope/telescope-live-grep-args.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
  },

  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    ft = {
      'typescript',
      'typescriptreact',
    },
  },

  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {
        view = {
          number = true,
          relativenumber = true,
        },
      }
    end,
    keys = {
      {
        '<leader>e',
        '<cmd>NvimTreeToggle<CR>',
        desc = '[E]xplorer',
      },
    },
  },
}
