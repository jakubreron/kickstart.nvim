vim.pack.add {
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/nvim-mini/mini.nvim', -- if you use the mini.nvim suite
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
}
require('render-markdown').setup {
  file_types = { 'markdown', 'vimwiki' },
} -- only mandatory if you want to set custom options

vim.treesitter.language.register('markdown', 'vimwiki')
