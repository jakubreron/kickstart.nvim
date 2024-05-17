local M = {
  c = {
    p = {
      "yiwOconst t0 = performance.now();<ESC>oconst t1 = performance.now();<ESC>oconsole.log(`%c <ESC>pa call took ${t1 - t0} milliseconds`, 'font-size: 24px; color: green;');<ESC>dkp",
      '[p]erformance console.log',
    },
  },
  u = {
    name = '[u]nit tests',
    r = {
      function()
        vim.cmd "lua require('neotest').output_panel.clear()"
        vim.cmd "lua require('neotest').run.run()"
      end,
      '[r]un nearest',
    },
    f = {
      function()
        vim.cmd "lua require('neotest').output_panel.clear()"
        vim.cmd "lua require('neotest').run.run(vim.fn.expand('%'))"
      end,
      'run [f]ile',
    },
    l = {
      function()
        vim.cmd "lua require('neotest').output_panel.clear()"
        vim.cmd "lua require('neotest').run.run_last()"
      end,
      'run [l]ast',
    },
    s = { "<cmd>lua require('neotest').run.stop()<cr>", '[s]top' },
    t = { "<cmd>lua require('neotest').summary.toggle()<cr>", 'summary [t]ree' },
    w = { "<cmd>lua require('neotest').run.run({ jestCommand = 'jest --watch ' })<cr>", '[w]atch' },
    c = {
      function()
        vim.cmd "lua require('neotest').summary.toggle()"
        vim.cmd "lua require('neotest').output_panel.toggle()"
      end,
      '[c]ombo: summary tree + output panel',
    },
    a = { "<cmd>lua require('neotest').run.attach()<cr>", '[a]ttach' },
    p = { "<cmd>lua require('neotest').output_panel.toggle()<cr>", '[p]anel toggle' },
    o = { "<cmd>lua require('neotest').output.open({ enter = true })<cr>", '[o]utput' },
  },
}

return M
