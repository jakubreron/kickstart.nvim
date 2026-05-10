-- 1. Configuration (Must be set BEFORE loading the plugin)
vim.g.vimwiki_list = {
  {
    path = vim.fn.expand '$VIMWIKI_DIR',
    syntax = 'markdown',
    ext = '.md',
  },
}

vim.pack.add { 'https://github.com/vimwiki/vimwiki' }

vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = vim.fs.joinpath(vim.fn.expand '$VIMWIKI_DIR', 'diary', '*.md'),
  callback = function(event) vim.cmd('silent 0r !~/.local/bin/generate-vimwiki-diary-template ' .. vim.fn.shellescape(event.file)) end,
})
