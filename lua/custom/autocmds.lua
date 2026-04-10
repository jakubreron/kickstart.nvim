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
