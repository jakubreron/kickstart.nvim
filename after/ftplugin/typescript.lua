local status_ok, which_key = pcall(require, 'which-key')
if not status_ok then
  return
end

local leader_typescript_mappings = require 'custom.keymaps.ftplugin.which_key.typescript'
local leader_javascript_typescript_mappings = require 'custom.keymaps.ftplugin.which_key.javascript-and-typescript'

local normal_javascript_typescript_mappings = require 'custom.keymaps.ftplugin.normal.javascript-and-typescript'
local normal_typescript_mappings = require 'custom.keymaps.ftplugin.normal.typescript'

local current_buf = vim.api.nvim_get_current_buf()

local opts = {
  mode = 'n',
  prefix = '<leader>',
  buffer = current_buf,
  silent = true,
  noremap = true,
  nowait = true,
}

which_key.register(leader_typescript_mappings, opts)
which_key.register(leader_javascript_typescript_mappings, opts)

normal_javascript_typescript_mappings.config(current_buf)
normal_typescript_mappings.config(current_buf)
