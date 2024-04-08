local M = {
  f = {
    r = { '<cmd>TSToolsRenameFile<CR>', '[r]ename' },
    R = { '<cmd>TSToolsFileReferences<CR>', '[R]eferences' },
  },
  l = {
    i = {
      name = '[i]mports',
      o = { '<cmd>TSToolsOrganizeImports<CR>', '[o]rganize' },
      s = { '<cmd>TSToolsSortImports<CR>', '[s]ort' },
      r = { '<cmd>TSToolsRemoveUnusedImports<CR>', '[r]emove unused' },
      a = { '<cmd>TSToolsAddMissingImports<CR>', '[a]dd missing' },
    }, -- default is :LspInfo
    o = {
      name = '[o]rganize',
      r = { '<cmd>TSToolsRemoveUnused<CR>', '[r]emove unused statements' },
      f = { '<cmd>TSToolsFixAll<CR>', '[f]ix fixable errors' },
    }, -- [o]rganize
  },
}

vim.keymap.set('n', 'gd', '<cmd>TSToolsGoToSourceDefinition<CR>', {
  desc = '[g]oto [d]efiniton',
  buffer = vim.api.nvim_get_current_buf(),
})

return M
