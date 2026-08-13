vim.pack.add { 'https://github.com/toppair/peek.nvim' }

require('peek').setup {
  filetype = { 'markdown', 'vimwiki' },
  app = 'browser',
}

vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})

vim.keymap.set('n', '<leader>wp', function()
  local peek = require 'peek'
  if peek.is_open() then
    peek.close()
  else
    peek.open()
  end
end, { desc = 'Markdown preview' })
