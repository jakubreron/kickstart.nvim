vim.o.background = 'light'

vim.pack.add { 'https://github.com/ellisonleao/gruvbox.nvim' }
require('gruvbox').setup {
  transparent_mode = false,
  palette_overrides = {
    dark0 = '#1d2021',
    faded_yellow = '#956110', -- light theme yellow, the official #b57614 is only 3.3:1 on the light background
  },
}
vim.cmd.colorscheme 'gruvbox'
