local Mappings = {}

Mappings.config = function(bufnr)
  vim.keymap.set('n', 'gR', '<cmd>TSToolsFileReferences<cr>', {
    desc = '[g]oto file [R]eference',
    buffer = bufnr,
  })

  vim.keymap.set('n', 'gd', '<cmd>TSToolsGoToSourceDefinition<cr>', {
    desc = '[g]oto [d]efiniton',
    buffer = bufnr,
  })
end

return Mappings
