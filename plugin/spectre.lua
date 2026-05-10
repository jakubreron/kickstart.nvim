vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-pack/nvim-spectre',
}

require('spectre').setup {
  replace_engine = {
    ['sed'] = {
      cmd = 'sed',
      args = { '-i', '', '-E' },
    },
  },
}

vim.keymap.set('n', '<leader>ra', require('spectre').open, { desc = 'spectre: [a]ll' })
vim.keymap.set('n', '<leader>ru', function() require('spectre').open_visual { select_word = true } end, { desc = 'spectre: [u]nder cursor' })
