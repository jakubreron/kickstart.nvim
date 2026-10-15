vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.hl_op() end,
})

-- NOTE: performance settings
vim.api.nvim_create_autocmd({ 'BufReadPre' }, {
  pattern = { '*/node_modules/*' },
  callback = function(event)
    vim.diagnostic.enable(false, { bufnr = event.buf })

    vim.bo[event.buf].readonly = true
    vim.bo[event.buf].undolevels = 10

    vim.opt_local.undofile = false
    vim.opt_local.syntax = 'off'
    vim.opt_local.foldenable = false
    vim.opt_local.list = false
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'text', 'vimwiki' },
  command = 'setlocal spell',
})
