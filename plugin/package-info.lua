local configured = false
vim.api.nvim_create_autocmd('BufRead', {
  pattern = 'package.json',
  callback = function(event)
    if not configured then
      configured = true
      vim.pack.add {
        'https://github.com/MunifTanjim/nui.nvim',
        'https://github.com/vuki656/package-info.nvim',
      }
      require('package-info').setup {}
    end
    local package_info = require 'package-info'
    vim.keymap.set('n', '<leader>lna', function() package_info.install() end, { buffer = event.buf, desc = '[a]dd' })
    vim.keymap.set('n', '<leader>lnd', function() package_info.delete() end, { buffer = event.buf, desc = '[d]elete' })
    vim.keymap.set('n', '<leader>lnf', function() package_info.show { force = true } end, { buffer = event.buf, desc = '[f]etch' })
    vim.keymap.set('n', '<leader>lnh', function() package_info.hide() end, { buffer = event.buf, desc = '[h]ide' })
    vim.keymap.set('n', '<leader>lnu', function() package_info.update() end, { buffer = event.buf, desc = '[u]pdate' })
    vim.keymap.set('n', '<leader>lnr', function() package_info.reinstall() end, { buffer = event.buf, desc = '[r]einstall' })
    vim.keymap.set('n', '<leader>lnc', function() package_info.change_version() end, { buffer = event.buf, desc = '[c]hange version' })
  end,
})
