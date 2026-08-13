-- must be set before vim-tmux-navigator loads
vim.g.tmux_navigator_no_wrap = 1
vim.g.tmux_navigator_disable_when_zoomed = 1

vim.pack.add { 'https://github.com/christoomey/vim-tmux-navigator' }

-- plugin maps these in terminal mode too; undo that so insert-mode in :term works normally
vim.schedule(function()
  for _, key in ipairs { '<C-h>', '<C-j>', '<C-k>', '<C-l>' } do
    pcall(vim.keymap.del, 't', key)
  end
end)
