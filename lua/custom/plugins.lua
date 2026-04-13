---@module 'lazy'
---@type LazySpec
return {
  -- Needed for neovim types in config
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },

  {
    'vimwiki/vimwiki',
    cmd = { 'VimwikiIndex', 'VimwikiDiaryIndex' },
    event = 'BufWinEnter ' .. vim.fn.expand '$VIMWIKI_DIR' .. '/*',
    keys = {
      '<leader>w',
    },
    config = function()
      vim.api.nvim_create_autocmd('BufNewFile', {
        pattern = '**/diary/*.md',
        callback = function(event) vim.cmd('silent 0r !~/.local/bin/generate-vimwiki-diary-template ' .. vim.fn.shellescape(event.file)) end,
      })
    end,
  },

  {
    'vuki656/package-info.nvim',
    dependencies = 'MunifTanjim/nui.nvim',
    event = 'BufRead package.json',
    config = true,
  },

  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    ---@module 'gitsigns'
    ---@type Gitsigns.Config
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        vim.keymap.set('n', ']c', function() gitsigns.nav_hunk 'next' end, { desc = 'next [g]it change', buffer = bufnr })
        vim.keymap.set('n', '[c', function() gitsigns.nav_hunk 'prev' end, { desc = 'prev git [c]hange', buffer = bufnr })
        vim.keymap.set('n', '<leader>gs', function() gitsigns.stage_hunk() end, { desc = 'git [s]tage hunk' })
        vim.keymap.set('n', '<leader>gr', function() gitsigns.reset_hunk() end, { desc = 'git [r]eset hunk' })
        vim.keymap.set('n', '<leader>gS', function() gitsigns.stage_buffer() end, { desc = 'git [S]tage buffer' })
        vim.keymap.set('n', '<leader>gR', function() gitsigns.reset_buffer() end, { desc = 'git [R]eset buffer' })
        vim.keymap.set('n', '<leader>gp', function() gitsigns.preview_hunk() end, { desc = 'git [p]review hunk' })
      end,
    },
  },

  {
    'folke/ts-comments.nvim',
    opts = {},
    event = 'VeryLazy',
  },

  {
    'nat-418/boole.nvim',
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
    },
    keys = {
      '<C-a>',
      '<C-x>',
    },
  },

  {
    'nvim-mini/mini.nvim',
    event = 'VeryLazy',
    config = function()
      require('mini.icons').setup {}
      require('mini.pairs').setup {}
      require('mini.operators').setup {
        evaluate = {
          prefix = 'g=', -- [=] Evaluate text and replace with output
        },
        exchange = {
          prefix = 'ga', -- [a]rrange text regions
          reindent_linewise = true, -- Whether to reindent new text to match previous indent
        },
        multiply = {
          prefix = 'gm', -- [m]ultiply (duplicate) text
          func = nil, -- Function which can modify text before multiplying
        },
        replace = {
          prefix = 'gs', -- [s]wap text with register
          reindent_linewise = true, -- Whether to reindent new text to match previous indent
        },
        sort = { prefix = '' },
      }
    end,
  },

  {
    'eero-lehtinen/oklch-color-picker.nvim',
    event = 'VeryLazy',
    version = '*',
    keys = {
      -- One handed keymap recommended, you will be using the mouse
      {
        '<leader>c',
        function() require('oklch-color-picker').pick_under_cursor() end,
        desc = 'Color pick under cursor',
      },
    },
    ---@type oklch.Opts
    opts = {},
  },

  {
    'nvim-neotest/neotest', -- run tests directly from the file
    event = { 'BufReadPost *.{spec,test}.{ts,js,tsx,jsx}' },
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
          vim.opt_local.number = true
          vim.opt_local.relativenumber = true
        end,
      })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'javascript', 'typescript', 'typescriptreact' },
        callback = function(event)
          local neotest = require 'neotest'
          local set_keymap = function(keybind, command, desc) vim.keymap.set('n', keybind, command, { buffer = event.buf, desc = desc }) end

          set_keymap(']u', function() neotest.jump.next { status = 'failed' } end, 'next failed [u]nit test')
          set_keymap('[u', function() neotest.jump.prev { status = 'failed' } end, 'previous failed [u]nit test')

          set_keymap('<leader>ur', function()
            neotest.output_panel.clear()
            neotest.run.run()
          end, '[r]un nearest')
          set_keymap('<leader>uf', function()
            neotest.output_panel.clear()
            neotest.run.run(vim.fn.expand '%')
          end, 'run [f]ile')
          set_keymap('<leader>ul', function()
            neotest.output_panel.clear()
            neotest.run.run_last()
          end, 'run [l]ast')
          set_keymap('<leader>uc', function()
            neotest.summary.toggle()
            neotest.output_panel.toggle()
          end, '[c]ombo: summary tree + output panel')

          set_keymap('<leader>us', function() neotest.run.stop() end, '[s]top')
          set_keymap('<leader>ut', function() neotest.summary.toggle() end, 'summary [t]ree')
          set_keymap('<leader>uw', function() neotest.watch.toggle(vim.fn.expand '%') end, '[w]atch file')
          set_keymap('<leader>ua', function() neotest.run.attach() end, '[a]ttach')
          set_keymap('<leader>up', function() neotest.output_panel.toggle() end, '[p]anel toggle')
          set_keymap('<leader>uo', function() neotest.output.open { enter = true } end, '[o]utput')
          set_keymap('<leader>uR', function() neotest.summary.run_marked() end, '[R]un marked')
          set_keymap('<leader>uL', function()
            local last = neotest.run.get_last_run()
            if last then vim.notify(vim.inspect(last), vim.log.levels.INFO, { title = 'neotest last run' }) end
          end, 'show [L]ast run info')
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
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      keymaps = {
        ['<C-l>'] = false, -- refresh
        ['<C-h>'] = false, -- horizontal split
        ['~'] = false, -- cwd to current dir (cannot change the case)
      },
      view_options = {
        show_hidden = true,
      },
      lsp_file_methods = {
        timeout_ms = 15000,
      },
    },
    cmd = { 'Oil' },
    keys = {
      { '-', '<cmd>Oil<cr>', desc = '[-] explorer' },
    },
  },

  {
    'nvim-pack/nvim-spectre', -- search & replace throughout all the files (without vimgrepping)
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
        function() require('spectre').open() end,
        desc = '[a]ll',
      },
      {
        '<leader>ru',
        function() require('spectre').open_visual { select_word = true } end,
        desc = '[u]nder cursor',
      },
    },
  },

  {
    'Wansmer/treesj',
    keys = {
      { 'gJ', '<cmd>TSJJoin<cr>', desc = '[J]oin' },
      { 'gS', '<cmd>TSJSplit<cr>', desc = '[S]plit' },
    },
    opts = { use_default_keymaps = false },
  },

  {
    'christoomey/vim-tmux-navigator', -- tmux navigation from within nvim
    cmd = { 'TmuxNavigateLeft', 'TmuxNavigateDown', 'TmuxNavigateUp', 'TmuxNavigateRight', 'TmuxNavigatePrevious' },
    keys = { '<C-h>', '<C-j>', '<C-k>', '<C-l>', '<C-\\>' },
    init = function()
      vim.g.tmux_navigator_no_wrap = 1
      vim.g.tmux_navigator_disable_when_zoomed = 1
      vim.g.tmux_navigator_save_on_switch = 2
    end,
  },

  {
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    config = true,
  },

  {
    'coder/claudecode.nvim',
    dependencies = { 'folke/snacks.nvim' },
    config = true,
    keys = {
      { '<leader>a', nil, desc = 'AI/Claude Code' },
      { '<leader>ac', '<cmd>ClaudeCode<cr>', desc = 'Toggle Claude' },
      { '<leader>af', '<cmd>ClaudeCodeFocus<cr>', desc = 'Focus Claude' },
      { '<leader>ar', '<cmd>ClaudeCode --resume<cr>', desc = 'Resume Claude' },
      { '<leader>aC', '<cmd>ClaudeCode --continue<cr>', desc = 'Continue Claude' },
      { '<leader>am', '<cmd>ClaudeCodeSelectModel<cr>', desc = 'Select Claude model' },
      { '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', desc = 'Add current buffer' },

      -- Send to claude, from buffer or oil
      { '<leader>as', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = 'Send to Claude' },
      {
        '<leader>as',
        '<cmd>ClaudeCodeTreeAdd<cr>',
        desc = 'Add file',
        ft = { 'NvimTree', 'neo-tree', 'oil', 'minifiles', 'netrw' },
      },

      -- Diff management, optionally use :w to accept, :q to reject
      { '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', desc = 'Accept diff' },
      { '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', desc = 'Deny diff' },
    },
  },
}
