local console_log = "console.log('%c', 'font-size: 24px; color: skyblue;')<ESC>02f'i "

local M = {
  c = {
    L = { "O" .. console_log, "console.log above" },
    l = { "o" .. console_log, "console.log below" },
    p = {
      "yiwOconst t0 = performance.now();<ESC>oconst t1 = performance.now();<ESC>oconsole.log(`%c <ESC>pa call took ${t1 - t0} milliseconds`, 'font-size: 24px; color: green;');<ESC>dkp",
      "Performance console.log",
    },
  },
  u = {
    name = "[U]nit Tests",
    r = {
      function()
        vim.cmd "lua require('neotest').output_panel.clear()"
        vim.cmd "lua require('neotest').run.run()"
      end,
      "[R]un Nearest",
    },
    f = {
      function()
        vim.cmd "lua require('neotest').output_panel.clear()"
        vim.cmd "lua require('neotest').run.run(vim.fn.expand('%'))"
      end,
      "Run [F]ile",
    },
    l = {
      function()
        vim.cmd "lua require('neotest').output_panel.clear()"
        vim.cmd "lua require('neotest').run.run_last()"
      end,
      "Run [L]ast",
    },
    s = { "<cmd>lua require('neotest').run.stop()<CR>", "[S]top" },
    t = { "<cmd>lua require('neotest').summary.toggle()<CR>", "Summary [T]ree" },
    w = { "<cmd>lua require('neotest').run.run({ jestCommand = 'jest --watch ' })<cr>", "[W]atch" },
    c = {
      function()
        vim.cmd "lua require('neotest').summary.toggle()"
        vim.cmd "lua require('neotest').output_panel.toggle()"
      end,
      "[C]ombo: Summary Tree + Output Panel",
    },
    a = { "<cmd>lua require('neotest').run.attach()<CR>", "[A]ttach" },
    p = { "<cmd>lua require('neotest').output_panel.toggle()<CR>", "[P]anel Toggle" },
    o = { "<cmd>lua require('neotest').output.open({ enter = true })<CR>", "[O]utput" },
  },
}

return M
