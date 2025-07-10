return {
  {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    ---@module 'gitsigns'
    ---@type Gitsigns.Config
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        vim.keymap.set('n', ']c', function()
          gitsigns.nav_hunk 'next'
        end, { desc = 'next [g]it change', buffer = bufnr })
        vim.keymap.set('n', '[c', function()
          gitsigns.nav_hunk 'prev'
        end, { desc = 'prev git [c]hange', buffer = bufnr })
        vim.keymap.set('n', '<leader>gs', function()
          gitsigns.stage_hunk()
        end, { desc = 'git [s]tage hunk' })
        vim.keymap.set('n', '<leader>gr', function()
          gitsigns.reset_hunk()
        end, { desc = 'git [r]eset hunk' })
        vim.keymap.set('n', '<leader>gS', function()
          gitsigns.stage_buffer()
        end, { desc = 'git [S]tage buffer' })
        vim.keymap.set('n', '<leader>gR', function()
          gitsigns.reset_buffer()
        end, { desc = 'git [R]eset buffer' })
        vim.keymap.set('n', '<leader>gp', function()
          gitsigns.preview_hunk()
        end, { desc = 'git [p]review hunk' })
      end,
    },
  },
}
