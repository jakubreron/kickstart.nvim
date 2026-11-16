vim.o.background = 'light'

vim.pack.add { 'https://github.com/ellisonleao/gruvbox.nvim' }
require('gruvbox').setup {
  transparent_mode = false,
  palette_overrides = {
    dark0 = '#1d2021',
    faded_yellow = '#956110', -- light theme yellow, the official #b57614 is only 3.3:1 on the light background
  },
}
-- gruvbox.nvim uses one gray for comments in both themes, only 3.2:1 on the light background
local LIGHT_COMMENT_COLOR = 0x665c54 -- gruvbox dark3
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'gruvbox',
  callback = function()
    if vim.o.background ~= 'light' then
      return
    end
    local comment = vim.api.nvim_get_hl(0, { name = 'Comment', link = false })
    comment.fg = LIGHT_COMMENT_COLOR
    vim.api.nvim_set_hl(0, 'Comment', comment)
  end,
})

vim.cmd.colorscheme 'gruvbox'
