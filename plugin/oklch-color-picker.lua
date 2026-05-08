vim.pack.add {
  {
    src = 'https://github.com/eero-lehtinen/oklch-color-picker.nvim',
    version = vim.version.range '*',
  },
}
require('oklch-color-picker').setup {}

vim.keymap.set('n', '<leader>v', function() require('oklch-color-picker').pick_under_cursor() end, { desc = 'Color pick under cursor' })
