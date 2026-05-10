vim.pack.add {
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
}

require('nvim-treesitter').install {
  'bash',
  'c',
  'html',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'vim',
  'vimdoc',
  'diff',
  'tsx',
  'typescript',
  'comment',
  'javascript',
  'css',
  'scss',
  'vue',
  'json',
  'jsdoc',
  'yaml',
  'toml',
  'hyprlang',
  'regex',
  'query',
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = { '*' },
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if lang and vim.treesitter.language.add(lang) then vim.treesitter.start(args.buf) end
  end,
})
