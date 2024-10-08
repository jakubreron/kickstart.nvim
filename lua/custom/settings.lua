-- vim.opt.dictionary = '/usr/share/dict/words' -- ctrl-x ctrl-k word suggestion
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.backup = false -- creates a backup file
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.swapfile = false -- creates a swapfile
vim.opt.title = true -- set the title of window to the value of the titlestring
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
vim.opt.lazyredraw = true -- Don't redraw while executing macros (good performance config)
vim.opt.laststatus = 3
vim.opt.wrap = false
vim.opt.jumpoptions = 'stack,view' -- preserve the jump position on the screen (if I jumped from "zb" position, I should go back there, instead of to "zz")
-- vim.opt.winbar = '  %t' -- file title

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
  underline = true,
  virtual_text = false,
  float = {
    show_header = true,
    border = 'rounded',
    source = 'if_many',
  },
}

-- add border to all hover actions
local border = {
  { '╭', 'FloatBorder' },
  { '─', 'FloatBorder' },
  { '╮', 'FloatBorder' },
  { '│', 'FloatBorder' },
  { '╯', 'FloatBorder' },
  { '─', 'FloatBorder' },
  { '╰', 'FloatBorder' },
  { '│', 'FloatBorder' },
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
