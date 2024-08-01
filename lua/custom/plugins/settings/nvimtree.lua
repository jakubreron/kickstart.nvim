local status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not status_ok then
  return
end

nvim_tree.setup {
  on_attach = function(bufnr)
    local api = require 'nvim-tree.api'

    local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.set('n', 'l', api.node.open.edit, opts 'Open')
    vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts 'Close')
  end,
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  auto_reload_on_write = true,
  reload_on_bufenter = false,
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  disable_netrw = false, -- disabling netrw disables gx for opening URLs
  git = {
    enable = true,
    ignore = false,
    show_on_dirs = true,
    show_on_open_dirs = true,
    timeout = 400,
  },
  filesystem_watchers = {
    enable = true,
    debounce_delay = 50,
    ignore_dirs = {},
  },
  update_focused_file = {
    enable = true,
    update_root = false,
    ignore_list = {},
  },
  renderer = {
    full_name = true,
    indent_markers = {
      enable = true,
    },
  },
  view = {
    adaptive_size = true,
    number = true,
    relativenumber = true,
    centralize_selection = false,
  },
}
