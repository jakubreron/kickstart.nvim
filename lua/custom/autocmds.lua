vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
  pattern = '*',
  group = vim.api.nvim_create_augroup('autoread-changes', { clear = true }),
  command = 'checktime',
})

vim.api.nvim_create_autocmd('BufRead', {
  pattern = '*',
  group = vim.api.nvim_create_augroup('return-to-lastposition', { clear = true }),
  command = 'normal g\'"'
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile', 'LspAttach' }, {
  pattern = { '.env*', '*/node_modules/*' },
  group = vim.api.nvim_create_augroup('lsp-performance', { clear = true }),
  callback = function(args)
    vim.diagnostic.disable(args.buf)
    vim.lsp.stop_client(args.buf)
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'neotest-output', 'neotest-output-panel', 'neotest-attach' },
  group = vim.api.nvim_create_augroup('neotest-settings', { clear = true }),
  callback = function()
    vim.cmd 'norm G'
    vim.cmd 'setlocal number'
    vim.cmd 'setlocal relativenumber'
  end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.tfvars',
  group = vim.api.nvim_create_augroup('local-filetypes', { clear = true }),
  command = 'setlocal filetype=tf',
})
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.conf',
  group = vim.api.nvim_create_augroup('local-filetypes', { clear = true }),
  command = 'setlocal filetype=conf',
})
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '.env*' },
  group = vim.api.nvim_create_augroup('local-filetypes', { clear = true }),
  command = 'setlocal filetype=sh',
})

vim.api.nvim_create_autocmd({ 'VimLeave' }, {
  pattern = 'bm-*',
  group = vim.api.nvim_create_augroup('renew-shorcuts', { clear = true }),
  command = '!shortcuts',
})

local auto_commit = function(type, scope)
  return "git add .; git commit -m '" .. type .. '(' .. scope .. "): ⚙️ auto-commit changes'; git pull && git push;"
end

vim.api.nvim_create_autocmd({ 'VimLeave' }, {
  pattern = vim.fn.expand '$VIMWIKI_DIR' .. '/*',
  group = vim.api.nvim_create_augroup('auto-commits', { clear = true }),
  callback = function()
    vim.fn.jobstart(auto_commit('docs', 'vimwiki'), { detach = true })
  end,
})

vim.api.nvim_create_autocmd({ 'VimLeave' }, {
  pattern = {
    vim.fn.expand '$HOME' .. '/.config/shell/aliasrc*',
    vim.fn.expand '$HOME' .. '/.config/shell/profile*',
    vim.fn.expand '$HOME' .. '/.config/ticker/.ticker.yaml',
    'bm-*',
  },
  group = vim.api.nvim_create_augroup('auto-commits', { clear = true }),
  callback = function()
    local filename = vim.fn.expand '%:t'
    vim.fn.jobstart(auto_commit('config', filename), { detach = true })
  end,
})
