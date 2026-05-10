vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- run TSUpdate whenever nvim-treesitter is updated
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
      vim.cmd 'TSUpdate'
    end
  end,
})

-- NOTE: reload the buffer
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
  pattern = '*',
  callback = function(event)
    local is_real_file = vim.bo[event.buf].buftype == ''
    local is_node_module = string.find(event.file, 'node_modules')

    if is_real_file and not is_node_module then vim.cmd 'silent! checktime' end
  end,
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
