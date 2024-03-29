local Mappings = {}

Mappings.config = function(bufnr)
  vim.keymap.set('n', ']u', "<cmd>lua require('neotest').jump.next({ status = 'failed' })<CR>", {
    buffer = bufnr,
    desc = 'Next Failed [u]nit Test',
  })
  vim.keymap.set('n', '[u', "<cmd>lua require('neotest').jump.prev({ status = 'failed' })<CR>", {
    buffer = bufnr,
    desc = 'Previous Failed [u]nit Test',
  })
end

return Mappings
