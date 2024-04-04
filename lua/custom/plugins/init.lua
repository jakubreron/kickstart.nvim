return {
  'tpope/vim-repeat', -- better "."
  'tpope/vim-unimpaired', -- additional mappings
  'AndrewRadev/splitjoin.vim',

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

  {
    'szw/vim-maximizer', -- maximize current window
    lazy = true,
    cmd = { 'MaximizerToggle' },
    keys = {
      {
        '<leader><leader>',
        '<cmd>MaximizerToggle!<cr>',
        desc = '[ ] Maximize',
      },
    },
  },

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
      { '<leader>ot', '<cmd>Obsession<cr>', desc = '[t]rack Session' },
      { '<leader>oT', ':Obsession Session-', desc = '[T]rack Custom Session' },
      { '<leader>os', '<cmd>source Session.vim<cr>', desc = '[s]ource Session' },
      { '<leader>oS', ':source Session-', desc = '[S]ource Custom Session' },
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
    config = function()
      require('custom.plugins.settings.neotest').config()
    end,
    event = 'BufWinEnter *.spec.*',
  },

  {
    'norcalli/nvim-colorizer.lua', -- highlight the hex / rgb colors
    lazy = true,
    config = function()
      require('custom.plugins.settings.colorizer').config()
    end,
    ft = {
      'css',
      'scss',
    },
  },

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
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    ft = {
      'javascript',
      'typescript',
      'typescriptreact',
    },
    config = true,
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
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('custom.plugins.settings.lualine').config()
    end,
    event = 'VimEnter',
  },
}
