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
        desc = '[ ] Maximize',
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
        '<leader>fo',
        '<cmd>Outline<CR>',
        desc = '[O]utline',
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
  {
    'tpope/vim-obsession',
    cmd = {
      'Obsession',
    },
    lazy = true,
    keys = {
      -- TODO: check if I can trigger a tab after doing it
      { '<leader>ot', '<cmd>Obsession<cr>', desc = '[t]rack Session' },
      { '<leader>oT', ':Obsession Session-', desc = '[T]rack Custom Session' },
      { '<leader>os', '<cmd>source Session.vim<cr>', desc = '[s]ource Session' },
      { '<leader>oS', ':source Session-', desc = '[S]ource Custom Session' },
    },
  }, -- save the session
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
      local neotest_status_ok, neotest = pcall(require, 'neotest')
      if not neotest_status_ok then
        return
      end

      neotest.setup {
        quickfix = {
          enabled = false,
          open = false,
        },

        summary = {
          open = 'topleft vsplit | vertical resize 50',
          animated = true,
          enabled = true,
          expand_errors = true,
          follow = true,
          mappings = {
            attach = 'a',
            clear_marked = 'M',
            clear_target = 'T',
            debug = 'd',
            debug_marked = 'D',
            expand = { '<CR>', '<2-LeftMouse>' },
            expand_all = 'e',
            jumpto = { 'i', 'l' },
            mark = 'm',
            next_failed = ']x',
            output = 'o',
            prev_failed = '[x',
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
          require 'neotest-jest' {
            -- jestCommand = "jest --watch",
            -- jestConfigFile = "tests/unit/jest.conf.js",
          },
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

      vim.keymap.set('n', ']u', "<cmd>lua require('neotest').jump.next({ status = 'failed' })<CR>", {
        desc = 'Next failed unit test',
      })
      vim.keymap.set('n', '[u', "<cmd>lua require('neotest').jump.prev({ status = 'failed' })<CR>", {
        desc = 'Previous failed unit test',
      })
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
      local status_ok, colorizer = pcall(require, 'colorizer')
      if not status_ok then
        return
      end

      colorizer.setup({ 'css', 'scss', 'html', 'javascript' }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        -- css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        -- css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
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
    keys = {
      {
        '<leader>ra',
        '<cmd>lua require("spectre").open()<cr>',
        desc = '[A]ll',
      },
      {
        '<leader>rw',
        '<cmd>lua require("spectre").open_visual({select_word=true})<cr>',
        desc = '[W]ord',
      },
    },
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
        on_attach = function(bufnr)
          local api = require 'nvim-tree.api'

          local function opts(desc)
            return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end

          api.config.mappings.default_on_attach(bufnr)

          vim.keymap.set('n', 'l', api.node.open.edit, opts 'Open')
          vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts 'Close')
          vim.keymap.set('n', 'C', api.tree.change_root_to_node, opts 'C')
        end,
        auto_reload_on_write = true,
        reload_on_bufenter = false,
        disable_netrw = true,
        git = {
          enable = true,
          ignore = false,
          show_on_dirs = true,
          show_on_open_dirs = true,
          timeout = 200,
        },
        filesystem_watchers = {
          enable = true,
          debounce_delay = 50,
          ignore_dirs = {},
        },
        update_focused_file = {
          enable = true,
          debounce_delay = 15,
          update_root = true,
          ignore_list = {},
        },
        renderer = {
          full_name = true,
          indent_markers = {
            enable = true,
          },
        },
        view = {
          number = true,
          relativenumber = true,
          centralize_selection = false,
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
