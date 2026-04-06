local javascript_and_typescript_mappings = require 'custom.ftplugin-keymaps.javascript-and-typescript'

local current_buf = vim.api.nvim_get_current_buf()

javascript_and_typescript_mappings.config(current_buf)
