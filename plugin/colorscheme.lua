vim.pack.add { 'https://github.com/ellisonleao/gruvbox.nvim' }
require('gruvbox').setup { transparent_mode = false }
vim.o.background = 'light'
vim.cmd.colorscheme 'gruvbox'
