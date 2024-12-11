local javascript_and_typescript_mappings = require 'custom.keymaps.ftplugin.javascript-and-typescript'
local typescript_mappings = require 'custom.keymaps.ftplugin.typescript'

local current_buf = vim.api.nvim_get_current_buf()

javascript_and_typescript_mappings.config(current_buf)
typescript_mappings.config(current_buf)
