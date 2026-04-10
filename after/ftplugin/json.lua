if vim.fn.expand '%:t' == 'package.json' then
  local bufnr = vim.api.nvim_get_current_buf()
  local package_info = require 'package-info'
  local set_keymap = function(key, command, desc) vim.keymap.set('n', key, command, { buffer = bufnr, desc = desc }) end

  set_keymap('<leader>lna', function() package_info.install() end, '[a]dd')
  set_keymap('<leader>lnd', function() package_info.delete() end, '[d]elete')
  set_keymap('<leader>lnf', function() package_info.show { force = true } end, '[f]etch')
  set_keymap('<leader>lnh', function() package_info.hide() end, '[h]ide')
  set_keymap('<leader>lnu', function() package_info.update() end, '[u]pdate')
  set_keymap('<leader>lnr', function() package_info.reinstall() end, '[r]einstall')
  set_keymap('<leader>lnc', function() package_info.change_version() end, '[c]hange version')
end
