return {
  'sangdol/mintabline.vim', -- tabs with numbers & icons
  'tpope/vim-repeat', -- better "."
  'tpope/vim-surround', -- surround movement
  'tpope/vim-unimpaired', -- additional mappings
  -- 'stevearc/dressing.nvim', -- better default nvim interfaces
  'christoomey/vim-titlecase', -- "gz" movement to toggle the words case
  'AndrewRadev/splitjoin.vim',

  {
    'vimwiki/vimwiki',
    lazy = true,
    cmd = { 'VimwikiIndex', 'VimwikiDiaryIndex' },
    keys = {
      '<leader>ww',
      '<leader>wi',
    },
  },

  {
    'szw/vim-maximizer',
    lazy = true,
    cmd = { 'MaximizerToggle' },
    keys = {
      {
        '<leader><leader>',
        '<cmd>MaximizerToggle!<cr>',
        desc = '[ ] Maximize',
      },
    },
  }, -- maximize current window

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
    'christoomey/vim-tmux-navigator',
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
  }, -- tmux navigation from within nvim

  {
    'tpope/vim-obsession',
    lazy = false, -- do not lazyload it since it can be pre-enabled with nvim -S
    cmd = { 'Obsession' },
    keys = {
      { '<leader>ot', '<cmd>Obsession<cr>', desc = '[t]rack Session' },
      { '<leader>oT', ':Obsession Session-', desc = '[T]rack Custom Session' },
      { '<leader>os', '<cmd>source Session.vim<cr>', desc = '[s]ource Session' },
      { '<leader>oS', ':source Session-', desc = '[S]ource Custom Session' },
    },
  }, -- save the session

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
    -- TODO: check if I can lazyload it using config = true + load only on certain filetypes / events
    opts = {},
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
