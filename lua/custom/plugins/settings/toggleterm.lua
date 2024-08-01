local status_ok, toggleterm_terminal = pcall(require, 'toggleterm.terminal')

if not status_ok then
  return
end

local term = nil

vim.api.nvim_create_user_command('LazyGitToggle', function()
  local Terminal = toggleterm_terminal.Terminal

  local size = 95
  local direction = 'float'

  if not term then
    term = Terminal:new {
      cmd = 'lazygit',
      hidden = true,
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
