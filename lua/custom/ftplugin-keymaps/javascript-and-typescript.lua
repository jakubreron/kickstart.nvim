local M = {}

M.config = function(bufnr)
  local neotest_status_ok = pcall(require, 'neotest')

  if neotest_status_ok then
    local set_normal_keymap = function(keybind, command, desc)
      vim.keymap.set('n', keybind, command, {
        buffer = bufnr,
        desc = desc,
      })
    end

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
end
return M
