local M = {
  f = {
    r = { '<cmd>TSToolsRenameFile<CR>', '[R]ename' },
    R = { '<cmd>TSToolsFileReferences<CR>', '[R]eferences' },
  },
  l = {
    i = {
      name = '[I]mports',
      o = { '<cmd>TSToolsOrganizeImports<CR>', '[O]rganize' },
      s = { '<cmd>TSToolsSortImports<CR>', '[S]ort' },
      r = { '<cmd>TSToolsRemoveUnusedImports<CR>', '[R]emove Unused' },
      a = { '<cmd>TSToolsAddMissingImports<CR>', '[A]dd Missing' },
    }, -- default is :LspInfo
    o = {
      name = '[O]rganize',
      r = { '<cmd>TSToolsRemoveUnused<CR>', '[R]emove Unused Statements' },
      f = { '<cmd>TSToolsFixAll<CR>', '[F]ix fixable errors' },
    }, -- [o]rganize
  },
}

vim.keymap.set('n', 'gd', '<cmd>TSToolsGoToSourceDefinition<CR>', {
  desc = '[G]oto [D]efiniton',
  buffer = vim.api.nvim_get_current_buf(),
})

return M
