-- vim.opt.dictionary = '/usr/share/dict/words' -- ctrl-x ctrl-k word suggestion
vim.opt.swapfile = false -- creates a swapfile
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
-- vim.opt.cmdheight = 0 -- NOTE: not enabled since there is no way to see if macro is being recorded

vim.opt.spelllang:append 'cjk' -- disable spellchecking for asian characters (VIM algorithm does not support it)

vim.filetype.add {
  pattern = {
    ['.*/hypr/.*%.conf'] = 'hyprlang',
    ['[jt]sconfig.*.json'] = 'jsonc',
    ['%.env.*'] = 'sh',
  },
  extension = {
    tfvars = 'tf',
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
