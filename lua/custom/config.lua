-- NOTE: reload the buffer
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
  pattern = '*',
  callback = function()
    local bufname = vim.fn.expand '<afile>'
    if not string.match(bufname, 'node_modules') then vim.cmd 'checktime' end
  end,
})

-- NOTE: performance settings
vim.api.nvim_create_autocmd({ 'BufRead' }, {
  pattern = { '*/node_modules/*' },
  callback = function(args)
    vim.diagnostic.enable(false, { bufnr = args.buf })

    vim.opt_local.undofile = false
    vim.opt_local.autoindent = false
    vim.opt_local.smartindent = false
    vim.opt_local.undolevels = 10
    vim.opt_local.syntax = 'off'
    vim.opt_local.foldenable = false
    vim.opt_local.buftype = 'nowrite'
    vim.opt_local.bufhidden = 'unload'
    vim.opt_local.modifiable = false
    vim.opt_local.list = false
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'text', 'vimwiki' },
  callback = function() vim.opt_local.spell = true end,
})

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

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

vim.cmd [[
  iabbrev PP PERF:<ESC>gcc^f:a
  iabbrev HH HACK:<ESC>gcc^f:a
  iabbrev TT TODO: @Jakub<ESC>gcc^fba
  iabbrev NN NOTE:<ESC>gcc^f:a
  iabbrev WW WARNING:<ESC>gcc^f:a
  iabbrev FF FIX:<ESC>gcc^f:a

  iabbrev tsi @ts-ignore<ESC>gcc
  iabbrev esi eslint-disable<ESC>gcc
  iabbrev bii biome-ignore<ESC>gcc
]]
