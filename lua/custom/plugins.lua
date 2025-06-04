---@module 'lazy'
---@type LazySpec
return {
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
    'vuki656/package-info.nvim',
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
    'nat-418/boole.nvim',
    lazy = true,
    opts = {
      mappings = {
        increment = '<C-a>',
        decrement = '<C-x>',
      },
      additions = {
        { 'child',       'parent' },
        { 'toBeTruthy',  'toBeFalsy' },
        { 'toBeEnabled', 'toBeDisabled' },
        { 'left',        'center',      'right' },
        { 'light',       'dark' },
      },
    },
    keys = {
      '<C-a>',
      '<C-x>',
    },
  },

  {
    'echasnovski/mini.nvim',
    lazy = true,
    event = 'VeryLazy',
    config = function()
      require('mini.icons').setup {}
      require('mini.pairs').setup {}

      local hipatterns = require 'mini.hipatterns'
      hipatterns.setup {
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      }

      require('mini.operators').setup {
        evaluate = {
          prefix = 'g=', -- [=] Evaluate text and replace with output
        },
        exchange = {
          prefix = 'ga',            -- [a]rrange text regions
          reindent_linewise = true, -- Whether to reindent new text to match previous indent
        },
        multiply = {
          prefix = 'gm', -- [m]ultiply (duplicate) text
          func = nil,    -- Function which can modify text before multiplying
        },
        replace = {
          prefix = 'gs',            -- [s]wap text with register
          reindent_linewise = true, -- Whether to reindent new text to match previous indent
        },
        sort = { prefix = '' },
      }
    end,
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
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'neotest-output', 'neotest-output-panel', 'neotest-attach' },
        callback = function()
          vim.cmd 'norm G'
          vim.cmd 'setlocal number'
          vim.cmd 'setlocal relativenumber'
        end,
      })

      local neotest = require 'neotest'
      ---@diagnostic disable-next-line: missing-fields
      neotest.setup {
        ---@diagnostic disable-next-line: missing-fields
        summary = { open = 'topleft vsplit | vertical resize 50' },
        output_panel = { enabled = true, open = 'rightbelow vsplit | resize 75' },
        adapters = {
          require 'neotest-jest' {},
          require 'neotest-vitest' {},
        },
      }
    end,
  },

  {
    'tpope/vim-obsession', -- save the session
    lazy = true,
    cmd = { 'Obsession' },
    keys = {
      { '<leader>ot', '<cmd>Obsession<cr>',                              desc = '[t]rack session' },
      { '<leader>oT', ':Obsession Session-.vim<Left><Left><Left><Left>', desc = '[T]rack custom session' },
      { '<leader>os', '<cmd>source Session.vim<cr>',                     desc = '[s]ource session' },
      { '<leader>oS', ':source Session-',                                desc = '[S]ource custom session' },
    },
    event = 'SessionLoadPost',
  },

  {
    'stevearc/oil.nvim',
    lazy = false, -- needed to hijack netrw
    ft = 'netrw',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      keymaps = {
        ['<C-l>'] = false, -- refresh
        ['<C-h>'] = false, -- horizontal split
        ['~'] = false,     -- cwd to current dir (cannot change the case)
      },
      view_options = {
        show_hidden = true,
      },
      lsp_file_methods = {
        timeout_ms = 50000,
      },
      git = {
        add = function()
          return true
        end,
        mv = function()
          return true
        end,
        rm = function()
          return true
        end,
      },
    },
    cmd = { 'Oil' },
    keys = {
      { '-', '<cmd>Oil<cr>', desc = '[-] explorer' },
    },
  },

  {
    'nvim-pack/nvim-spectre', -- search & replace throughout all the files (without vimgrepping)
    lazy = true,
    opts = {
      replace_engine = {
        ['sed'] = {
          cmd = 'sed',
          args = { '-i', '', '-E' },
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
        '<leader>ru',
        '<cmd>lua require("spectre").open_visual({select_word=true})<cr>',
        desc = '[u]under cursor',
      },
    },
  },

  {
    'Wansmer/treesj',
    lazy = true,
    keys = {
      { 'gJ', '<cmd>TSJJoin<cr>',  desc = '[J]oin' },
      { 'gS', '<cmd>TSJSplit<cr>', desc = '[S]plit' },
    },
    opts = { use_default_keymaps = false },
  },

  {
    'christoomey/vim-tmux-navigator', -- tmux navigation from within nvim
    lazy = true,
    cmd = { 'TmuxNavigateLeft', 'TmuxNavigateDown', 'TmuxNavigateUp', 'TmuxNavigateRight', 'TmuxNavigatePrevious' },
    keys = { '<C-h>', '<C-j>', '<C-k>', '<C-l>', '<C-\\>' },
    config = function()
      vim.g.tmux_navigator_no_wrap = 1
      vim.g.tmux_navigator_disable_when_zoomed = 1
      vim.g.tmux_navigator_save_on_switch = 2
    end,
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      file_types = { 'markdown', 'vimwiki' },
    },
    config = function()
      vim.treesitter.language.register('markdown', 'vimwiki')
    end,
  },

  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = true,
  },
}
