local status_ok, which_key = pcall(require, 'which-key')
if not status_ok then
  return
end

local which_key_typescript_mappings = require 'custom.keymaps.ftplugin.which_key.typescript'
local which_key_javascript_typescript_mappings = require 'custom.keymaps.ftplugin.which_key.javascript-and-typescript'
local normal_javascript_typescript_mappings = require 'custom.keymaps.ftplugin.normal.javascript-and-typescript'
local current_buf = vim.api.nvim_get_current_buf()

local opts = {
  mode = 'n',
  prefix = '<leader>',
  buffer = current_buf,
  silent = true,
  noremap = true,
  nowait = true,
}

which_key.register(which_key_typescript_mappings, opts)
which_key.register(which_key_javascript_typescript_mappings, opts)

normal_javascript_typescript_mappings.config(current_buf)
