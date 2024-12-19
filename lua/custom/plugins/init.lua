return {
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
    'kevinhwang91/nvim-bqf',
    lazy = true,
    event = 'QuickFixCmdPre',
    ft = 'qf',
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
    config = function()
      vim.g.vimwiki_list = {
        {
          path = vim.fn.expand '$VIMWIKI_DIR',
          syntax = 'markdown',
          ext = '.md',
        },
      }
    end,
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
    event = 'VeryLazy',
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
}
