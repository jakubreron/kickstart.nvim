local M = {}

M.config = function(bufnr)
  local set_normal_keymap = function(keybind, command, desc)
    vim.keymap.set('n', keybind, command, {
      buffer = bufnr,
      desc = desc,
    })
  end

  set_normal_keymap(
    '<leader>cp',
    "yiwOconst t0 = performance.now();<ESC>oconst t1 = performance.now();<ESC>oconsole.log(`%c <ESC>pa call took ${t1 - t0} milliseconds`, 'font-size: 24px; color: green;');<ESC>dkp",
    '[p]erformance console.log'
  )

  require('which-key').add {
    { '<leader>u', desc = '[u]nit tests', icon = '󰙨' },
  }

  set_normal_keymap(']u', "<cmd>lua require('neotest').jump.next({ status = 'failed' })<cr>", 'next failed [u]nit test')
  set_normal_keymap('[u', "<cmd>lua require('neotest').jump.prev({ status = 'failed' })<cr>", 'previous failed [u]nit test')
  set_normal_keymap('<leader>ur', function()
    vim.cmd "lua require('neotest').output_panel.clear()"
    vim.cmd "lua require('neotest').run.run()"
  end, '[r]un nearest')
  set_normal_keymap('<leader>uf', function()
    vim.cmd "lua require('neotest').output_panel.clear()"
    vim.cmd "lua require('neotest').run.run(vim.fn.expand('%'))"
  end, 'run [f]ile')
  set_normal_keymap('<leader>ul', function()
    vim.cmd "lua require('neotest').output_panel.clear()"
    vim.cmd "lua require('neotest').run.run_last()"
  end, 'run [l]ast')
  set_normal_keymap('<leader>uc', function()
    vim.cmd "lua require('neotest').summary.toggle()"
    vim.cmd "lua require('neotest').output_panel.toggle()"
  end, '[c]ombo: summary tree + output panel')
  set_normal_keymap('<leader>us', '<cmd>lua require("neotest").run.stop()<cr>', '[s]top')
  set_normal_keymap('<leader>ut', '<cmd>lua require("neotest").summary.toggle()<cr>', 'summary [t]ree')
  set_normal_keymap('<leader>uw', '<cmd>lua require("neotest").run.run({ jestCommand = "jest --watch " })<cr>', '[w]atch')
  set_normal_keymap('<leader>ua', '<cmd>lua require("neotest").run.attach()<cr>', '[a]ttach')
  set_normal_keymap('<leader>up', '<cmd>lua require("neotest").output_panel.toggle()<cr>', '[p]anel toggle')
  set_normal_keymap('<leader>uo', '<cmd>lua require("neotest").output.open({ enter = true })<cr>', '[o]utput')
end

return M
