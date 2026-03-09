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

    vim.cmd 'setlocal noundofile'
    vim.cmd 'setlocal noautoindent'
    vim.cmd 'setlocal nosmartindent'
    vim.cmd 'setlocal undolevels=10'
    vim.cmd 'setlocal syntax=off'
    vim.cmd 'setlocal nofoldenable'
    vim.cmd 'setlocal buftype=nowrite'
    vim.cmd 'setlocal bufhidden=unload'
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'text', 'vimwiki' },
  callback = function() vim.cmd 'setlocal spell' end,
})
