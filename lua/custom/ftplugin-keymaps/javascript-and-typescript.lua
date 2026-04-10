local M = {}

M.config = function(bufnr)
  local set_normal_keymap = function(keybind, command, desc)
    vim.keymap.set('n', keybind, command, {
      buffer = bufnr,
      desc = desc,
    })
  end

  set_normal_keymap(']u', function() require('neotest').jump.next({ status = 'failed' }) end, 'next failed [u]nit test')
  set_normal_keymap('[u', function() require('neotest').jump.prev({ status = 'failed' }) end, 'previous failed [u]nit test')

  set_normal_keymap('<leader>ur', function()
    require('neotest').output_panel.clear()
    require('neotest').run.run()
  end, '[r]un nearest')
  set_normal_keymap('<leader>uf', function()
    require('neotest').output_panel.clear()
    require('neotest').run.run(vim.fn.expand('%'))
  end, 'run [f]ile')
  set_normal_keymap('<leader>ul', function()
    require('neotest').output_panel.clear()
    require('neotest').run.run_last()
  end, 'run [l]ast')
  set_normal_keymap('<leader>uc', function()
    require('neotest').summary.toggle()
    require('neotest').output_panel.toggle()
  end, '[c]ombo: summary tree + output panel')

  set_normal_keymap('<leader>us', function() require('neotest').run.stop() end, '[s]top')
  set_normal_keymap('<leader>ut', function() require('neotest').summary.toggle() end, 'summary [t]ree')
  set_normal_keymap('<leader>uw', function() require('neotest').run.run({ jestCommand = 'jest --watch ' }) end, '[w]atch')
  set_normal_keymap('<leader>ua', function() require('neotest').run.attach() end, '[a]ttach')
  set_normal_keymap('<leader>up', function() require('neotest').output_panel.toggle() end, '[p]anel toggle')
  set_normal_keymap('<leader>uo', function() require('neotest').output.open({ enter = true }) end, '[o]utput')
end
return M