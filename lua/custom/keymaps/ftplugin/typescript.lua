local M = {}

local action_with_formatting = function(command)
  return function()
    vim.cmd(command)

    vim.defer_fn(function()
      require('conform').format { async = true, lsp_fallback = false }
    end, 200)
  end
end

M.config = function(bufnr)
  vim.keymap.set('n', 'gR', '<cmd>TSToolsFileReferences<cr>', {
    desc = '[g]oto file [R]eference',
    buffer = bufnr,
  })

  vim.keymap.set('n', 'gd', '<cmd>TSToolsGoToSourceDefinition<cr>', {
    desc = '[g]oto [d]efiniton',
    buffer = bufnr,
  })

  vim.keymap.set('n', '<leader>fr', action_with_formatting 'TSToolsRenameFile', {
    desc = '[r]ename',
    buffer = bufnr,
  })

  require('which-key').add {
    { '<leader>li', desc = '[i]mports', icon = '󰋺' },
    { '<leader>lo', desc = '[o]rganize', icon = '󰒺' },
  }

  vim.keymap.set('n', '<leader>lio', action_with_formatting 'TSToolsOrganizeImports', {
    desc = '[o]rganize',
    buffer = bufnr,
  })
  vim.keymap.set('n', '<leader>lis', action_with_formatting 'TSToolsSortImports', {
    desc = '[s]ort',
    buffer = bufnr,
  })
  vim.keymap.set('n', '<leader>lir', action_with_formatting 'TSToolsRemoveUnusedImports', {
    desc = '[r]emove unused',
    buffer = bufnr,
  })
  vim.keymap.set('n', '<leader>lia', action_with_formatting 'TSToolsAddMissingImports', {
    desc = '[a]dd missing',
    buffer = bufnr,
  })

  vim.keymap.set('n', '<leader>lor', action_with_formatting 'TSToolsRemoveUnused', {
    desc = '[r]emove unused statements',
    buffer = bufnr,
  })
  vim.keymap.set('n', '<leader>lof', action_with_formatting 'TSToolsFixAll', {
    desc = '[f]ix fixable errors',
    buffer = bufnr,
  })
end

return M
