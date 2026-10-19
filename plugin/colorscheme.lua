vim.o.background = 'light'

vim.pack.add { 'https://github.com/ellisonleao/gruvbox.nvim' }
require('gruvbox').setup {
  transparent_mode = false,
  palette_overrides = {
    dark0 = '#000000',
  },
}
vim.cmd.colorscheme 'gruvbox'
