local Mappings = {}

Mappings.config = function(bufnr)
  vim.keymap.set('n', ']u', "<cmd>lua require('neotest').jump.next({ status = 'failed' })<CR>", {
    buffer = bufnr,
    desc = 'next failed [u]nit test',
  })
  vim.keymap.set('n', '[u', "<cmd>lua require('neotest').jump.prev({ status = 'failed' })<CR>", {
    buffer = bufnr,
    desc = 'previous failed [u]nit test',
  })
end

return Mappings
