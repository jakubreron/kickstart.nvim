local action_with_formatting = function(command)
  return function()
    vim.cmd(command)

    vim.defer_fn(function()
      require('conform').format { async = true, lsp_fallback = false }
    end, 200)
  end
end

local M = {
  f = {
    r = { action_with_formatting 'TSToolsRenameFile', '[r]ename' },
    R = { action_with_formatting 'TSToolsFileReferences', '[R]eferences' },
  },
  l = {
    i = {
      name = '[i]mports',
      o = { action_with_formatting 'TSToolsOrganizeImports', '[o]rganize' },
      s = { action_with_formatting 'TSToolsSortImports', '[s]ort' },
      r = { action_with_formatting 'TSToolsRemoveUnusedImports', '[r]emove unused' },
      a = { action_with_formatting 'TSToolsAddMissingImports', '[a]dd missing' },
    },
    o = {
      name = '[o]rganize',
      r = { action_with_formatting 'TSToolsRemoveUnused', '[r]emove unused statements' },
      f = { action_with_formatting 'TSToolsFixAll', '[f]ix fixable errors' },
    },
  },
}

vim.keymap.set('n', 'gd', '<cmd>TSToolsGoToSourceDefinition<cr>', {
  desc = '[g]oto [d]efiniton',
  buffer = vim.api.nvim_get_current_buf(),
})

return M