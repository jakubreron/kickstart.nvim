return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    lazy = true,
    keys = {
      {
        '<leader>gl',
        '<cmd>LazyGitToggle<cr>i',
        desc = '[l]azygit toggle',
      },
    },
    config = function()
      local toggleterm_terminal = require 'toggleterm.terminal'
      local term = nil

      vim.api.nvim_create_user_command('LazyGitToggle', function()
        local Terminal = toggleterm_terminal.Terminal

        local size = 100
        local direction = 'float'

        if not term then
          term = Terminal:new {
            cmd = 'lazygit',
            hidden = true,
            float_opts = {
              border = 'curved',
              winblend = 4,
            },
            on_exit = function()
              term = nil
            end,
          }

          if term then
            term:toggle(size, direction)

            vim.cmd 'set ft=lazygit'
            vim.keymap.set('t', 'q', function()
              term:toggle(size, direction)
            end, { buffer = true })
          end
        else
          term:toggle(size, direction)
        end
      end, {})
    end,
  },
}
