vim.pack.add { 'https://github.com/nvim-mini/mini.nvim' }

require('mini.icons').setup {}
require('mini.pairs').setup {}
require('mini.operators').setup {
  evaluate = { prefix = 'g=' },
  exchange = { prefix = 'ga', reindent_linewise = true },
  multiply = { prefix = 'gm', func = nil },
  replace = { prefix = 'gs', reindent_linewise = true },
  sort = { prefix = '' },
}
