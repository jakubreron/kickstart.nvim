return {
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
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    init = function()
      vim.o.background = 'light'
      vim.cmd.colorscheme 'gruvbox'
    end,
    opts = {
      transparent_mode = false,
      contrast = 'hard',
    },
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
      vim.api.nvim_create_autocmd('User', {
        pattern = 'GitConflictDetected',
        callback = function()
          vim.notify('Conflict detected in ' .. vim.fn.expand '<afile>')

          require('conform').setup { format_on_save = nil }
        end,
      })

      vim.api.nvim_create_autocmd('User', {
        pattern = 'GitConflictResolved',
        callback = function()
          vim.notify('Conflict resolved in ' .. vim.fn.expand '<afile>')

          require('conform').setup {
            format_on_save = {
              timeout_ms = 500,
              lsp_format = 'never',
            },
          }
        end,
      })
    end,
  },
  {
    'echasnovski/mini.nvim',
    lazy = true,
    event = 'VeryLazy',
    config = function()
      require('mini.ai').setup { n_lines = 500 }

      require('mini.bracketed').setup {
        comment = { suffix = '/', options = {} },

        treesitter = { suffix = '', options = {} },
        undo = { suffix = '', options = {} },
        window = { suffix = '', options = {} },
        yank = { suffix = '', options = {} },
      }

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

      require('mini.surround').setup {
        -- I liked tpope bindings more
        mappings = {
          add = 'ys', -- Add surrounding in Normal and Visual modes
          delete = 'ds', -- Delete surrounding
          replace = 'cs', -- Replace surrounding

          -- unused / unnecessary
          find = '', -- Find surrounding (to the right)
          find_left = '', -- Find surrounding (to the left)
          update_n_lines = '', -- Update `n_lines`
          highlight = '', -- Highlight surrounding
        },

        -- Number of lines within which surrounding is searched
        n_lines = 500,
      }

      require('mini.operators').setup {
        -- [=] Evaluate text and replace with output
        evaluate = {
          prefix = 'g=',
        },

        -- [a]rrange text regions
        exchange = {
          prefix = 'ga',
          reindent_linewise = true, -- Whether to reindent new text to match previous indent
        },

        -- [m]ultiply (duplicate) text
        multiply = {
          prefix = 'gm',
          func = nil, -- Function which can modify text before multiplying
        },

        -- [s]wap text with register
        replace = {
          prefix = 'gs',
          reindent_linewise = true, -- Whether to reindent new text to match previous indent
        },

        sort = { prefix = '' },
      }

      require('which-key').add {
        { 'g=', desc = '[=]evaluate', icon = '' },
        { 'g==', desc = '[=]evaluate current line', icon = '' },

        { 'ga', desc = 'exch[a]nge text', icon = '' },
        { 'gaa', desc = 'exch[a]nge current line', icon = '' },

        { 'gm', desc = '[m]ultiply text', icon = '' },
        { 'gmm', desc = '[m]ultiply current line', icon = '' },

        { 'gs', desc = '[s]wap text', icon = '' },
        { 'gss', desc = '[s]wap current line', icon = '' },
      }

      -- local statusline = require 'mini.statusline'
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
      local function get_vitest_adapter()
        -- NOTE: it was being attached to monorepo that contains both jest and vitest
        if not string.match(vim.fn.expand '%:p', vim.g.monorepo_name) then
          return require 'neotest-vitest' {}
        end
      end

      neotest.setup {
        jump = {
          enabled = true,
        },

        output = {
          open_on_run = false,
        },

        quickfix = {
          enabled = false,
          open = false,
        },

        summary = {
          open = 'topleft vsplit | vertical resize 50',
          animated = true,
          enabled = true,
          expand_errors = false,
          follow = true,
          mappings = {
            attach = 'a',
            clear_marked = 'M',
            clear_target = 'T',
            debug = 'd',
            debug_marked = 'D',
            expand = { '<cr>', '<2-LeftMouse>' },
            expand_all = 'e',
            jumpto = { 'i', 'l' },
            mark = 'm',
            next_failed = ']u',
            output = 'o',
            prev_failed = '[u',
            run = 'r',
            run_marked = 'R',
            short = 'O',
            stop = 'u',
            target = 't',
          },
        },
        output_panel = {
          enabled = true,
          open = 'rightbelow vsplit | resize 75',
        },

        adapters = {
          require 'neotest-jest' {},
          get_vitest_adapter(),
        },
      }

      local neodev_status_ok, neodev = pcall(require, 'neodev')
      if not neodev_status_ok then
        return
      end

      neodev.setup {
        library = {
          plugins = { 'neotest' },
          types = true,
        },
      }
    end,
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
    'stevearc/oil.nvim',
    lazy = false, -- needed to hijack netrw
    ft = 'netrw',
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      columns = {
        'icon',
        'size',
      },
      keymaps = {
        ['<C-l>'] = false, -- refresh
        ['<C-h>'] = false, -- horizontal split
        ['<C-s>'] = false, -- vertical split
        ['~'] = false, -- cwd to current dir (cannot change the case)
      },
      view_options = {
        show_hidden = true,
      },
      lsp_file_methods = {
        timeout_ms = 50000,
      },
      git = {
        -- Return true to automatically git add/mv/rm files
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
    cmd = {
      'Oil',
    },
    keys = {
      {
        '-',
        '<cmd>Oil<cr>',
        desc = '[-] explorer',
      },
    },
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
      '<C-h>',
      '<C-j>',
      '<C-k>',
      '<C-l>',
      '<C-\\>',
    },
    config = function()
      vim.g.tmux_navigator_no_wrap = 1
      vim.g.tmux_navigator_disable_when_zoomed = 1
      vim.g.tmux_navigator_save_on_switch = 2
    end,
  },
}
