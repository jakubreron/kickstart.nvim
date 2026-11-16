vim.o.background = 'light'

vim.pack.add { 'https://github.com/ellisonleao/gruvbox.nvim' }
require('gruvbox').setup {
  transparent_mode = false,
  palette_overrides = {
    dark0 = '#1d2021',
  },
}
vim.cmd.colorscheme 'gruvbox'
