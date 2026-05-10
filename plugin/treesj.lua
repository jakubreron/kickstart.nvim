vim.pack.add { 'https://github.com/Wansmer/treesj' }

require('treesj').setup { use_default_keymaps = false }

vim.keymap.set('n', 'gJ', function() vim.cmd 'TSJJoin' end, { desc = '[J]oin' })
vim.keymap.set('n', 'gS', function() vim.cmd 'TSJSplit' end, { desc = '[S]plit' })
