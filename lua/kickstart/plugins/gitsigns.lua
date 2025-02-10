return {
  {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        vim.keymap.set('n', ']g', function()
          gitsigns.nav_hunk 'next'
        end, { desc = 'next [g]it change', buffer = bufnr })
        vim.keymap.set('n', '[g', function()
          gitsigns.nav_hunk 'prev'
        end, { desc = 'prev [g]it change', buffer = bufnr })

        -- visual mode
        vim.keymap.set('v', '<leader>gs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = '[s]tage hunk', buffer = bufnr })
        vim.keymap.set('v', '<leader>gr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = '[r]eset hunk', buffer = bufnr })

        -- normal mode
        vim.keymap.set('n', '<leader>gr', gitsigns.reset_hunk, { desc = '[r]eset hunk', buffer = bufnr })
        vim.keymap.set('n', '<leader>gR', gitsigns.reset_buffer, { desc = '[R]eset buffer', buffer = bufnr })
        vim.keymap.set('n', '<leader>gp', gitsigns.preview_hunk, { desc = '[p]review hunk', buffer = bufnr })
        vim.keymap.set('n', '<leader>gb', gitsigns.blame_line, { desc = '[b]lame line', buffer = bufnr })
        vim.keymap.set('n', '<leader>gd', function()
          gitsigns.diffthis '@'
        end, { desc = '[d]iff against last commit' })
      end,
    },
  },
}
