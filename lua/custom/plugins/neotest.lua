return {
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
}
