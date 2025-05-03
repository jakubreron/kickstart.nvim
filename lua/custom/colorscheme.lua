return {
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    init = function()
      vim.o.background = 'light'
      vim.cmd.colorscheme 'gruvbox'
    end,
    opts = {
      transparent_mode = false,
    },
  },
}
