local Mappings = {}

Mappings.config = function(bufnr)
  vim.keymap.set('n', ']u', "<cmd>lua require('neotest').jump.next({ status = 'failed' })<CR>", {
    buffer = bufnr,
    desc = 'Next Failed [U]nit Test',
  })
  vim.keymap.set('n', '[u', "<cmd>lua require('neotest').jump.prev({ status = 'failed' })<CR>", {
    buffer = bufnr,
    desc = 'Previous Failed [U]nit Test',
  })
end

return Mappings
