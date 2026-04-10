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

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'javascript', 'typescript', 'typescriptreact' },
  callback = function(event)
    local bufnr = event.buf
    local set_keymap = function(keybind, command, desc) vim.keymap.set('n', keybind, command, { buffer = bufnr, desc = desc }) end

    set_keymap(']u', function() require('neotest').jump.next { status = 'failed' } end, 'next failed [u]nit test')
    set_keymap('[u', function() require('neotest').jump.prev { status = 'failed' } end, 'previous failed [u]nit test')

    set_keymap('<leader>ur', function()
      require('neotest').output_panel.clear()
      require('neotest').run.run()
    end, '[r]un nearest')
    set_keymap('<leader>uf', function()
      require('neotest').output_panel.clear()
      require('neotest').run.run(vim.fn.expand '%')
    end, 'run [f]ile')
    set_keymap('<leader>ul', function()
      require('neotest').output_panel.clear()
      require('neotest').run.run_last()
    end, 'run [l]ast')
    set_keymap('<leader>uc', function()
      require('neotest').summary.toggle()
      require('neotest').output_panel.toggle()
    end, '[c]ombo: summary tree + output panel')

    set_keymap('<leader>us', function() require('neotest').run.stop() end, '[s]top')
    set_keymap('<leader>ut', function() require('neotest').summary.toggle() end, 'summary [t]ree')
    set_keymap('<leader>uw', function() require('neotest').run.run { jestCommand = 'jest --watch ' } end, '[w]atch')
    set_keymap('<leader>ua', function() require('neotest').run.attach() end, '[a]ttach')
    set_keymap('<leader>up', function() require('neotest').output_panel.toggle() end, '[p]anel toggle')
    set_keymap('<leader>uo', function() require('neotest').output.open { enter = true } end, '[o]utput')
  end,
})
