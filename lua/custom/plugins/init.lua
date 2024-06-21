return {
  { import = 'custom.plugins.colorschemes' },

  'tpope/vim-repeat', -- better "."
  'tpope/vim-unimpaired', -- additional mappings
  'AndrewRadev/splitjoin.vim',

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

  -- {
  --   'sangdol/mintabline.vim', -- tabs with numbers & icons
  --   lazy = true,
  --   event = 'TabEnter',
  -- },

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
    'ThePrimeagen/harpoon',
    lazy = true,
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup {
        settings = {
          save_on_toggle = true,
          sync_on_ui_close = true,
          key = function()
            return vim.loop.cwd()
          end,
        },
      }

      vim.keymap.set('n', '<C-f>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, {
        desc = 'toggle harpoon quick menu',
      })

      vim.keymap.set('n', '<C-b>', function()
        harpoon:list():add()
      end, {
        desc = 'add file to harpoon',
      })

      vim.keymap.set('n', ']h', function()
        harpoon:list():next()
      end, {
        desc = 'next [h]arpoon file',
      })

      vim.keymap.set('n', '[h', function()
        harpoon:list():prev()
      end, {
        desc = 'prev [h]arpoon file',
      })

      for i = 1, 6 do
        vim.keymap.set('n', '<leader>' .. i, function()
          harpoon:list():select(i)
        end, { desc = '[' .. i .. '] mark' })
      end
    end,
    keys = {
      '<C-f>',
      '<C-b>',
      ']h',
      '[h',
      '<leader>1',
      '<leader>2',
      '<leader>3',
      '<leader>4',
      '<leader>5',
      '<leader>6',
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
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      -- 'haydenmeade/neotest-jest',
      'marilari88/neotest-vitest',
    },
    config = function()
      require('custom.plugins.settings.neotest').config()
    end,
    keys = {
      '<leader>u',
    },
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
      'sass',
      'less',
      'html',
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
    lazy = true,
    dependencies = { 'nvim-lua/plenary.nvim' },
    ft = {
      'javascript',
      'typescript',
      'typescriptreact',
    },
    config = true,
  },

  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    lazy = true,
    ft = 'typescriptreact',
    config = function()
      require('ts_context_commentstring').setup {
        enable_autocmd = false,
      }

      local get_option = vim.filetype.get_option
      vim.filetype.get_option = function(filetype, option)
        return option == 'commentstring' and require('ts_context_commentstring.internal').calculate_commentstring() or get_option(filetype, option)
      end
    end,
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
        default_file_explorer = true,
        columns = {
          'icon',
          'size',
        },
        keymaps = {
          ['<C-l>'] = false, -- refresh
          ['<C-h>'] = false, -- horizontal split
          ['<C-s>'] = false, -- vertical split
          ['<C-v>'] = require('oil.actions').select_vsplit,
          ['<C-x>'] = require('oil.actions').select_split,
        },
        view_options = {
          show_hidden = true,
        },
        lsp_file_methods = {
          timeout_ms = 5000,
          autosave_changes = true,
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
        '<cmd>Oil --float<cr>',
        desc = '[-] explorer (floating window)',
      },
    },
  },

  -- {
  --   'nvim-tree/nvim-tree.lua',
  --   version = '*',
  --   lazy = true,
  --   dependencies = {
  --     'nvim-tree/nvim-web-devicons',
  --   },
  --   config = function()
  --     require('custom.plugins.settings.nvimtree').config()
  --   end,
  --   keys = {
  --     {
  --       '<leader>e',
  --       '<cmd>NvimTreeToggle<cr>',
  --       desc = '[e]xplorer',
  --     },
  --   },
  --   cmd = { 'NvimTreeToggle', 'NvimTreeOpen', 'NvimTreeFocus', 'NvimTreeFindFileToggle' },
  -- },

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
}
