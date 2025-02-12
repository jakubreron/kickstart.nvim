vim.keymap.set('n', 'p', ']p', { desc = '[p]aste' }) -- paste with indent

-- NOTE: toggle
vim.keymap.set('n', 'yoe', function()
  vim.cmd('set eventignore=' .. (vim.o.eventignore == '' and 'all' or ''))
  print(vim.o.eventignore == '' and 'Eventignore OFF' or 'Eventignore ON')
end, { desc = '[e]ventignore' })
vim.keymap.set('n', 'yor', '<cmd>setlocal relativenumber!<cr>', { desc = '[r]elativenumber toggle' })
vim.keymap.set('n', 'yow', '<cmd>setlocal wrap!<cr>', { desc = '[w]rap toggle' })
vim.keymap.set('n', 'yoss', '<cmd>setlocal spell!<cr>', { desc = '[s]pelling toggle' })
vim.keymap.set('n', 'yosp', '<cmd>setlocal spell! spelllang=pl<cr>', { desc = '[p]olish' })
vim.keymap.set('n', 'yose', '<cmd>setlocal spell! spelllang=en<cr>', { desc = '[e]nglish' })

-- fix weird terminal alignment after quitting to normal mode
vim.keymap.set('t', '<C-\\><C-n>', '<C-\\><C-n>0', { desc = 'exit terminal mode' })

-- NOTE: center search matches
vim.keymap.set('n', 'n', 'nzzzv', { silent = true })
vim.keymap.set('n', 'N', 'Nzzzv', { silent = true })
vim.keymap.set('n', 'J', 'mzJ`z', { silent = true })

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

-- NOTE: navigation
vim.keymap.set('t', '<C-h>', '<C-\\><C-N><C-w>h')
vim.keymap.set('t', '<C-j>', '<C-\\><C-N><C-w>j')
vim.keymap.set('t', '<C-k>', '<C-\\><C-N><C-w>k')
vim.keymap.set('t', '<C-l>', '<C-\\><C-N><C-w>l')

-- NOTE: lazy
vim.keymap.set('n', '<leader>ph', '<cmd>Lazy<cr>', { desc = '[h]ome' })
vim.keymap.set('n', '<leader>ps', '<cmd>Lazy sync<cr>', { desc = '[s]ync' })
vim.keymap.set('n', '<leader>px', '<cmd>Lazy clean<cr>', { desc = '[x]clean' })
vim.keymap.set('n', '<leader>pr', '<cmd>Lazy restore<cr>', { desc = '[r]estore' })

-- NOTE: replace
vim.keymap.set('n', '<leader>ru', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '[u]nder cursor' })

-- NOTE: switch to last tab
vim.api.nvim_create_autocmd('TabLeave', {
  callback = function()
    vim.api.nvim_set_keymap('n', '<leader><leader>', '<cmd>tabn ' .. vim.api.nvim_tabpage_get_number(0) .. '<cr>', { desc = '[ ] last tab' })
  end,
})
