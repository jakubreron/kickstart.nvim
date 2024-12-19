return {
  {
    'christoomey/vim-tmux-navigator', -- tmux navigation from within nvim
    lazy = true,
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      '<C-h>',
      '<C-j>',
      '<C-k>',
      '<C-l>',
      '<C-\\>',
    },
    config = function()
      vim.g.tmux_navigator_no_wrap = 1
      vim.g.tmux_navigator_disable_when_zoomed = 1
      vim.g.tmux_navigator_save_on_switch = 2
    end,
  },
}
