vim.g.vimwiki_list = {
  {
    path = vim.fn.expand '$VIMWIKI_DIR',
    syntax = 'markdown',
    ext = '.md',
  },
}

local function load_vimwiki()
  vim.pack.add { 'https://github.com/vimwiki/vimwiki' }
  vim.api.nvim_create_autocmd('BufNewFile', {
    pattern = '**/diary/*.md',
    callback = function(event) vim.cmd('silent 0r !~/.local/bin/generate-vimwiki-diary-template ' .. vim.fn.shellescape(event.file)) end,
  })
end

vim.api.nvim_create_autocmd('BufRead', {
  pattern = vim.fn.expand '$VIMWIKI_DIR' .. '/*',
  once = true,
  callback = load_vimwiki,
})

vim.keymap.set('n', '<leader>ww', function()
  load_vimwiki()
  vim.keymap.del('n', '<leader>ww')
  vim.cmd 'VimwikiIndex'
end, { desc = '[w]iki' })
