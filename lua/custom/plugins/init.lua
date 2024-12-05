return {
  { import = 'custom.plugins.colorschemes' },

  {
    'windwp/nvim-ts-autotag',
    lazy = true,
    opts = {
      opts = {
        -- Defaults
        enable_close = true, -- Auto close tags
        enable_rename = true, -- Auto rename pairs of tags
        enable_close_on_slash = false, -- Auto close on trailing </
      },
    },
    event = { 'BufReadPre', 'BufNewFile', 'VeryLazy' },
  },

  {
    'Wansmer/treesj',
    lazy = true,
    keys = {
      {
        'gJ',
        '<cmd>TSJJoin<cr>',
        desc = '[J]oin',
      },
      {
        'gS',
        '<cmd>TSJSplit<cr>',
        desc = '[S]plit',
      },
    },
    opts = {
      use_default_keymaps = false,
    },
  },

  {
    'kevinhwang91/nvim-bqf',
    lazy = true,
    event = 'QuickFixCmdPre',
    ft = 'qf',
  },

  {
    'nat-418/boole.nvim',
    lazy = true,
    opts = {
      mappings = {
        increment = '<C-a>',
        decrement = '<C-x>',
      },
      additions = {
        { 'child', 'parent' },
        { 'toBeTruthy', 'toBeFalsy' },
        { 'toBeEnabled', 'toBeDisabled' },
        { 'left', 'center', 'right' },
        { 'light', 'dark' },
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
    config = function()
      require('which-key').add {
        { 'gz', desc = '[z]Z titlecase', icon = '' },
        { 'gJ', desc = '[J]oin', icon = '󰦦' },
        { 'gS', desc = '[S]plit', icon = '󰦦' },
      }
    end,
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
    'mbbill/undotree',
    lazy = true,
    cmd = {
      'UndotreeToggle',
    },
    keys = {
      {
        '<leader>fu',
        '<cmd>UndotreeToggle<cr>',
        desc = '[u]undotree',
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
    lazy = true,
    cmd = { 'Obsession' },
    keys = {
      { '<leader>ot', '<cmd>Obsession<cr>', desc = '[t]rack session' },
      { '<leader>oT', ':Obsession Session-.vim<Left><Left><Left><Left>', desc = '[T]rack custom session' },
      { '<leader>os', '<cmd>source Session.vim<cr>', desc = '[s]ource session' },
      { '<leader>oS', ':source Session-', desc = '[S]ource custom session' },
    },
    event = 'SessionLoadPost',
  },

  {
    'nvim-neotest/neotest', -- run tests directly from the file
    lazy = true,
    event = 'BufWinEnter *.spec.*',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',

      'haydenmeade/neotest-jest',
      'marilari88/neotest-vitest',
    },
    config = function()
      require 'custom.plugins.settings.neotest'
    end,
  },

  {
    'nvim-pack/nvim-spectre', -- search & replace throughout all the files (without vimgrepping)
    lazy = true,
    opts = {
      replace_engine = {
        ['sed'] = {
          cmd = 'sed',
          args = {
            '-i',
            '',
            '-E',
          },
        },
      },
    },
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
    event = 'BufRead package.json',
    config = true,
  },

  {
    'pmizio/typescript-tools.nvim',
    lazy = true,
    dependencies = { 'nvim-lua/plenary.nvim' },
    ft = {
      'javascript',
      'typescript',
      'typescriptreact',
      'vue',
    },
    config = true,
  },

  {
    'folke/ts-comments.nvim',
    opts = {},
  },

  {
    'akinsho/git-conflict.nvim',
    version = '*',
    opts = {
      default_mappings = true, -- disable buffer local mapping created by this plugin
      default_commands = true, -- disable commands created by this plugin
      disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
      list_opener = 'copen', -- command or function to open the conflicts list
      highlights = { -- They must have background color, otherwise the default color will be used
        incoming = 'DiffAdd',
        current = 'DiffText',
      },
    },
    config = function()
      require 'custom.plugins.settings.git-conflict'
    end,
  },

  {
    'ramilito/winbar.nvim',
    event = 'VimEnter', -- Alternatively, BufReadPre if we don't care about the empty file when starting with 'nvim'
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      icons = true,
      diagnostics = true,
      buf_modified = true,
      buf_modified_symbol = '●',
      dir_levels = 2,
    },
  },

  {
    'stevearc/oil.nvim',
    lazy = false, -- needed to hijack netrw
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    ft = 'netrw',
    opts = {
      default_file_explorer = true,
      columns = {
        'icon',
        'size',
      },
      keymaps = {
        ['<C-l>'] = false, -- refresh
        ['<C-h>'] = false, -- horizontal split
        ['<C-s>'] = false, -- vertical split
        -- ['~'] = false, -- cwd to current dir (cannot change the case)
      },
      view_options = {
        show_hidden = true,
      },
      lsp_file_methods = {
        timeout_ms = 50000,
        autosave_changes = true,
      },
    },
    cmd = {
      'Oil',
    },
    keys = {
      {
        '-',
        '<cmd>Oil<cr>',
        desc = '[-] explorer',
      },
      {
        '<leader>-',
        '<cmd>Oil --float<cr>',
        desc = '[-] explorer (floating window)',
      },
    },
  },

  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require 'custom.plugins.settings.lualine'
    end,
    event = 'VimEnter',
  },

  {
    'akinsho/toggleterm.nvim',
    version = '*',
    lazy = true,
    keys = {
      {
        '<leader>gl',
        '<cmd>LazyGitToggle<cr>i',
        desc = '[l]azygit toggle',
      },
    },
    config = function()
      require 'custom.plugins.settings.toggleterm'
    end,
  },
}
