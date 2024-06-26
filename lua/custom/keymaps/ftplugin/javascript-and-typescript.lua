local Mappings = {}

Mappings.config = function(bufnr)
  vim.keymap.set('n', ']u', "<cmd>lua require('neotest').jump.next({ status = 'failed' })<cr>", {
    buffer = bufnr,
    desc = 'next failed [u]nit test',
  })
  vim.keymap.set('n', '[u', "<cmd>lua require('neotest').jump.prev({ status = 'failed' })<cr>", {
    buffer = bufnr,
    desc = 'previous failed [u]nit test',
  })

  vim.keymap.set(
    'n',
    '<leader>cp',
    "yiwOconst t0 = performance.now();<ESC>oconst t1 = performance.now();<ESC>oconsole.log(`%c <ESC>pa call took ${t1 - t0} milliseconds`, 'font-size: 24px; color: green;');<ESC>dkp",
    {
      buffer = bufnr,
      desc = '[p]erformance console.log',
    }
  )

  vim.keymap.set('n', '<leader>ur', function()
    vim.cmd "lua require('neotest').output_panel.clear()"
    vim.cmd "lua require('neotest').run.run()"
  end, {
    buffer = bufnr,
    desc = '[r]un nearest',
  })
  vim.keymap.set('n', '<leader>uf', function()
    vim.cmd "lua require('neotest').output_panel.clear()"
    vim.cmd "lua require('neotest').run.run(vim.fn.expand('%'))"
  end, {
    buffer = bufnr,
    desc = 'run [f]ile',
  })
  vim.keymap.set('n', '<leader>ul', function()
    vim.cmd "lua require('neotest').output_panel.clear()"
    vim.cmd "lua require('neotest').run.run_last()"
  end, {
    buffer = bufnr,
    desc = 'run [l]ast',
  })
  vim.keymap.set('n', '<leader>us', '<cmd>lua require("neotest").run.stop()<cr>', {
    buffer = bufnr,
    desc = '[s]top',
  })
  vim.keymap.set('n', '<leader>ut', '<cmd>lua require("neotest").summary.toggle()<cr>', {
    buffer = bufnr,
    desc = 'summary [t]ree',
  })
  vim.keymap.set('n', '<leader>uw', '<cmd>lua require("neotest").run.run({ jestCommand = "jest --watch " })<cr>', {
    buffer = bufnr,
    desc = '[w]atch',
  })
  vim.keymap.set('n', '<leader>uc', function()
    vim.cmd "lua require('neotest').summary.toggle()"
    vim.cmd "lua require('neotest').output_panel.toggle()"
  end, {
    buffer = bufnr,
    desc = '[c]ombo: summary tree + output panel',
  })
  vim.keymap.set('n', '<leader>ua', '<cmd>lua require("neotest").run.attach()<cr>', {
    buffer = bufnr,
    desc = '[a]ttach',
  })
  vim.keymap.set('n', '<leader>up', '<cmd>lua require("neotest").output_panel.toggle()<cr>', {
    buffer = bufnr,
    desc = '[p]anel toggle',
  })
  vim.keymap.set('n', '<leader>uo', '<cmd>lua require("neotest").output.open({ enter = true })<cr>', {
    buffer = bufnr,
    desc = '[o]utput',
  })
end

return Mappings
