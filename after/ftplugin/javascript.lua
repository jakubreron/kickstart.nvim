local javascript_typescript_mappings = require 'custom.keymaps.ftplugin.javascript-and-typescript'

local current_buf = vim.api.nvim_get_current_buf()

javascript_typescript_mappings.config(current_buf)
