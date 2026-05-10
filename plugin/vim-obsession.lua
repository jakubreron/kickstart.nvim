vim.pack.add { 'https://github.com/tpope/vim-obsession' }
vim.keymap.set('n', '<leader>ot', '<cmd>Obsession<cr>', { desc = '[t]rack session' })
vim.keymap.set('n', '<leader>oT', ':Obsession Session-.vim<Left><Left><Left><Left>', { desc = '[T]rack custom session' })
vim.keymap.set('n', '<leader>os', '<cmd>source Session.vim<cr>', { desc = '[s]ource session' })
vim.keymap.set('n', '<leader>oS', ':source Session-', { desc = '[S]ource custom session' })
