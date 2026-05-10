vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'neotest-output', 'neotest-output-panel', 'neotest-attach' },
  callback = function()
    vim.cmd 'norm G'
    vim.opt_local.number = true
    vim.opt_local.relativenumber = true
  end,
})

local pattern = {
  '*.spec.ts',
  '*.spec.js',
  '*.spec.tsx',
  '*.spec.jsx',
  '*.test.ts',
  '*.test.js',
  '*.test.tsx',
  '*.test.jsx',
}

vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
  once = true,
  pattern = pattern,
  callback = function()
    vim.pack.add {
      'https://github.com/nvim-neotest/nvim-nio',
      'https://github.com/nvim-lua/plenary.nvim',
      'https://github.com/haydenmeade/neotest-jest',
      'https://github.com/marilari88/neotest-vitest',
      'https://github.com/nvim-neotest/neotest',
    }

    ---@diagnostic disable-next-line: missing-fields
    require('neotest').setup {
      ---@diagnostic disable-next-line: missing-fields
      summary = { open = 'topleft vsplit | vertical resize 50' },
      output_panel = { enabled = true, open = 'rightbelow vsplit | resize 75' },
      adapters = {
        require 'neotest-jest' {},
        require 'neotest-vitest' {},
      },
    }
  end,
})

vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
  pattern = pattern,
  callback = function(event)
    local neotest = require 'neotest'

    vim.keymap.set('n', ']u', function() neotest.jump.next { status = 'failed' } end, { buffer = event.buf, desc = 'next failed' })
    vim.keymap.set('n', '[u', function() neotest.jump.prev { status = 'failed' } end, { buffer = event.buf, desc = 'prev failed' })
    vim.keymap.set('n', '<leader>ur', function()
      neotest.output_panel.clear()
      neotest.run.run()
    end, { buffer = event.buf, desc = 'run nearest' })
    vim.keymap.set('n', '<leader>uf', function()
      neotest.output_panel.clear()
      neotest.run.run(vim.fn.expand '%')
    end, { buffer = event.buf, desc = 'run file' })
    vim.keymap.set('n', '<leader>ul', function()
      neotest.output_panel.clear()
      neotest.run.run_last()
    end, { buffer = event.buf, desc = 'run last' })
    vim.keymap.set('n', '<leader>uc', function()
      neotest.summary.toggle()
      neotest.output_panel.toggle()
    end, { buffer = event.buf, desc = 'combo toggle' })
    vim.keymap.set('n', '<leader>us', function() neotest.run.stop() end, { buffer = event.buf, desc = 'stop' })
    vim.keymap.set('n', '<leader>ut', function() neotest.summary.toggle() end, { buffer = event.buf, desc = 'summary tree' })
    vim.keymap.set('n', '<leader>uw', function() neotest.watch.toggle(vim.fn.expand '%') end, { buffer = event.buf, desc = 'watch file' })
    vim.keymap.set('n', '<leader>ua', function() neotest.run.attach() end, { buffer = event.buf, desc = 'attach' })
    vim.keymap.set('n', '<leader>up', function() neotest.output_panel.toggle() end, { buffer = event.buf, desc = 'panel toggle' })
    vim.keymap.set('n', '<leader>uo', function() neotest.output.open { enter = true } end, { buffer = event.buf, desc = 'output' })
  end,
})
