vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', 'p', ']p', { desc = '[p]aste' }) -- paste with indent

-- NOTE: toggle
vim.keymap.set('n', 'yor', '<cmd>setlocal relativenumber!<cr>', { desc = '[r]elativenumber toggle' })

-- NOTE: jumplist every 5 lines jump with j/k
vim.keymap.set('n', 'k', 'v:count > 5 ? "m\'" .. v:count .. "k" : "k"', { expr = true, silent = true })
vim.keymap.set('n', 'j', 'v:count > 5 ? "m\'" .. v:count .. "j" : "j"', { expr = true, silent = true })

-- NOTE: emacs keybinds in command/insert mode
vim.keymap.set('c', '<C-a>', '<Home>')
vim.keymap.set('c', '<C-e>', '<End>')
vim.keymap.set('c', '<C-f>', '<Right>') -- NOTE: you can open command line window not only by c-f, but also q:, q/, q?
vim.keymap.set('c', '<C-b>', '<Left>')
vim.keymap.set('c', '<C-d>', '<Delete>')
vim.keymap.set('c', '<A-f>', '<C-Right>')
vim.keymap.set('c', '<A-b>', '<C-Left>')

-- NOTE: replace
vim.keymap.set('n', '<leader>ru', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '[u]nder cursor' })
