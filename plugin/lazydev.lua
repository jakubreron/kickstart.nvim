vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  once = true,
  callback = function()
    vim.pack.add { 'https://github.com/folke/lazydev.nvim' }

    require('lazydev').setup {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    }
  end,
})
