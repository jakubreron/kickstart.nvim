local status_ok, harpoon = pcall(require, 'harpoon')

if not status_ok then
  return
end

harpoon:setup {
  settings = {
    save_on_toggle = true,
    sync_on_ui_close = true,
    key = function()
      return vim.loop.cwd()
    end,
  },
}

vim.keymap.set('n', '<C-f>', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, {
  desc = 'toggle harpoon quick menu',
})

vim.keymap.set('n', '<C-b>', function()
  harpoon:list():add()
end, {
  desc = 'add file to harpoon',
})

vim.keymap.set('n', '] ', function()
  harpoon:list():next()
end, {
  desc = '[ ] next harpoon file',
})

vim.keymap.set('n', '[ ', function()
  harpoon:list():prev()
end, {
  desc = '[ ] prev harpoon file',
})

for i = 1, 6 do
  vim.keymap.set('n', '<leader>' .. i, function()
    harpoon:list():select(i)
  end, { desc = '[' .. i .. '] mark' })
end
