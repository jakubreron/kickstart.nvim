local M = {}

local action_with_formatting = function(command)
  return function()
    vim.cmd(command)

    vim.defer_fn(function()
      require('conform').format { async = true, lsp_fallback = false }
    end, 250)
  end
end

M.config = function(bufnr)
  local set_normal_keymap = function(keybind, command, desc)
    vim.keymap.set('n', keybind, command, {
      buffer = bufnr,
      desc = desc,
    })
  end

  set_normal_keymap('gd', '<cmd>TSToolsGoToSourceDefinition<cr>', '[g]oto [d]efiniton')
  set_normal_keymap('gR', '<cmd>TSToolsFileReferences<cr>', '[g]oto file [R]eference')
  set_normal_keymap('<leader>fr', action_with_formatting 'TSToolsRenameFile', '[r]ename')

  set_normal_keymap('<leader>lio', action_with_formatting 'TSToolsOrganizeImports', '[o]rganize')
  set_normal_keymap('<leader>lis', action_with_formatting 'TSToolsSortImports', '[s]ort')
  set_normal_keymap('<leader>lir', action_with_formatting 'TSToolsRemoveUnusedImports', '[r]emove unused')
  set_normal_keymap('<leader>lia', action_with_formatting 'TSToolsAddMissingImports', '[a]dd missing')
  set_normal_keymap('<leader>lor', action_with_formatting 'TSToolsRemoveUnused', '[r]emove unused statements')
  set_normal_keymap('<leader>lof', action_with_formatting 'TSToolsFixAll', '[f]ix fixable errors')
end

return M
