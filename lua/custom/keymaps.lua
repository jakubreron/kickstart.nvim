vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', 'p', ']p', { desc = '[p]aste' }) -- paste with indent

-- NOTE: toggle
vim.keymap.set('n', 'yor', '<cmd>setlocal relativenumber!<cr>', { desc = '[r]elativenumber toggle' })

-- NOTE: jumplist every 5 lines jump with j/k
vim.keymap.set('n', 'k', 'v:count > 5 ? "m\'" .. v:count .. "k" : "k"', { expr = true, silent = true })
vim.keymap.set('n', 'j', 'v:count > 5 ? "m\'" .. v:count .. "j" : "j"', { expr = true, silent = true })

-- NOTE: emacs keybinds in command/insert mode
-- Press C-f for vim movements
vim.keymap.set('c', '<C-a>', '<Home>')
vim.keymap.set('c', '<C-e>', '<End>')
vim.keymap.set('c', '<C-d>', '<Delete>')

-- NOTE: replace
vim.keymap.set('n', '<leader>rr', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'quickly [r]eplace under cursor' })
