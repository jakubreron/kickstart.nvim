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
