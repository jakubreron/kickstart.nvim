-- use var for vimwiki home dir
vim.g.vimwiki_list = {
  {
    path = vim.fn.expand '$VIMWIKI_DIR',
    syntax = 'markdown',
    ext = '.md',
  },
}

-- do not wrap tmux
vim.g.tmux_navigator_no_wrap = 1
vim.g.tmux_navigator_disable_when_zoomed = 1
vim.g.tmux_navigator_save_on_switch = 2
