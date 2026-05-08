local function load()
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
end

vim.keymap.set('n', '<leader>ra', function()
  if not package.loaded['spectre'] then load() end
  require('spectre').open()
end, { desc = '[a]ll' })

vim.keymap.set('n', '<leader>ru', function()
  if not package.loaded['spectre'] then load() end
  require('spectre').open_visual { select_word = true }
end, { desc = '[u]nder cursor' })
