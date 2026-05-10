vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'neotest-output', 'neotest-output-panel', 'neotest-attach' },
  callback = function()
    vim.cmd 'norm G'
    vim.opt_local.number = true
    vim.opt_local.relativenumber = true
  end,
})

local configured = false
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'javascript', 'typescript', 'typescriptreact' },
  callback = function(event)
    if not configured then
      configured = true
      vim.pack.add {
        'https://github.com/nvim-neotest/nvim-nio',
        'https://github.com/nvim-lua/plenary.nvim',
        'https://github.com/haydenmeade/neotest-jest',
        'https://github.com/marilari88/neotest-vitest',
        'https://github.com/nvim-neotest/neotest',
      }
      ---@diagnostic disable-next-line: missing-fields
      require('neotest').setup {
        summary = { open = 'topleft vsplit | vertical resize 50' },
        output_panel = { enabled = true, open = 'rightbelow vsplit | resize 75' },
        adapters = {
          require 'neotest-jest' {},
          require 'neotest-vitest' {},
        },
      }
    end

    local neotest = require 'neotest'
    vim.keymap.set('n', ']u', function() neotest.jump.next { status = 'failed' } end, { buffer = event.buf, desc = 'next failed [u]nit test' })
    vim.keymap.set('n', '[u', function() neotest.jump.prev { status = 'failed' } end, { buffer = event.buf, desc = 'previous failed [u]nit test' })
    vim.keymap.set('n', '<leader>ur', function()
      neotest.output_panel.clear()
      neotest.run.run()
    end, { buffer = event.buf, desc = '[r]un nearest' })
    vim.keymap.set('n', '<leader>uf', function()
      neotest.output_panel.clear()
      neotest.run.run(vim.fn.expand '%')
    end, { buffer = event.buf, desc = 'run [f]ile' })
    vim.keymap.set('n', '<leader>ul', function()
      neotest.output_panel.clear()
      neotest.run.run_last()
    end, { buffer = event.buf, desc = 'run [l]ast' })
    vim.keymap.set('n', '<leader>uc', function()
      neotest.summary.toggle()
      neotest.output_panel.toggle()
    end, { buffer = event.buf, desc = '[c]ombo: summary tree + output panel' })
    vim.keymap.set('n', '<leader>us', function() neotest.run.stop() end, { buffer = event.buf, desc = '[s]top' })
    vim.keymap.set('n', '<leader>ut', function() neotest.summary.toggle() end, { buffer = event.buf, desc = 'summary [t]ree' })
    vim.keymap.set('n', '<leader>uw', function() neotest.watch.toggle(vim.fn.expand '%') end, { buffer = event.buf, desc = '[w]atch file' })
    vim.keymap.set('n', '<leader>ua', function() neotest.run.attach() end, { buffer = event.buf, desc = '[a]ttach' })
    vim.keymap.set('n', '<leader>up', function() neotest.output_panel.toggle() end, { buffer = event.buf, desc = '[p]anel toggle' })
    vim.keymap.set('n', '<leader>uo', function() neotest.output.open { enter = true } end, { buffer = event.buf, desc = '[o]utput' })
    vim.keymap.set('n', '<leader>uR', function() neotest.summary.run_marked() end, { buffer = event.buf, desc = '[R]un marked' })
    vim.keymap.set('n', '<leader>uL', function()
      local last = neotest.run.get_last_run()
      if last then vim.notify(vim.inspect(last), vim.log.levels.INFO, { title = 'neotest last run' }) end
    end, { buffer = event.buf, desc = 'show [L]ast run info' })
  end,
})
