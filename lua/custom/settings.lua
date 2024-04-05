-- vim.opt.dictionary = '/usr/share/dict/words' -- ctrl-x ctrl-k word suggestion
vim.opt.backup = false -- creates a backup file
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.swapfile = false -- creates a swapfile
vim.opt.title = true -- set the title of window to the value of the titlestring
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
vim.opt.lazyredraw = true -- Don't redraw while executing macros (good performance config)
vim.opt.colorcolumn = '80'
-- vim.opt.winbar = '|%t|' -- file title

vim.opt.spelllang:append 'cjk' -- disable spellchecking for asian characters (VIM algorithm does not support it)
vim.opt.shortmess:append 'c' -- don't show redundant messages from ins-completion-menu
vim.opt.shortmess:append 'I' -- don't show the default intro message
vim.opt.whichwrap:append '<,>,[,],h,l'

vim.filetype.add {
  pattern = {
    ['.*/hypr/.*%.conf'] = 'hyprlang',
    ['[jt]sconfig.*.json'] = 'jsonc',
  },
}

vim.diagnostic.config {
  virtual_text = false,
  float = {
    border = 'rounded',
    source = 'always',
  },
}
