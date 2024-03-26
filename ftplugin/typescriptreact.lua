local status_ok, which_key = pcall(require, "which-key")
local ts_mappings = require "user.keymaps.typescript"
local js_ts_mappings = require "user.keymaps.js-ts"
if not status_ok then
  return
end

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = vim.api.nvim_get_current_buf(), -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

which_key.register(ts_mappings, opts)
which_key.register(js_ts_mappings, opts)
