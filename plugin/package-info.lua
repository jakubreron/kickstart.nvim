vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
  once = true,
  pattern = 'package.json',
  callback = function()
    vim.pack.add {
      'https://github.com/MunifTanjim/nui.nvim',
      'https://github.com/vuki656/package-info.nvim',
    }

    require('package-info').setup {}
  end,
})

vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
  pattern = 'package.json',
  callback = function(event)
    local package_info = require 'package-info'

    local function map(mode, keys, action, desc)
      vim.keymap.set(mode, keys, action, {
        buffer = event.buf,
        silent = true,
        desc = desc,
      })
    end

    map('n', '<leader>lna', function() package_info.install() end, '[a]dd')
    map('n', '<leader>lnd', function() package_info.delete() end, '[d]elete')
    map('n', '<leader>lnf', function() package_info.show { force = true } end, '[f]etch')
    map('n', '<leader>lnh', function() package_info.hide() end, '[h]ide')
    map('n', '<leader>lnu', function() package_info.update() end, '[u]pdate')
    map('n', '<leader>lnr', function() package_info.reinstall() end, '[r]einstall')
    map('n', '<leader>lnc', function() package_info.change_version() end, '[c]hange version')
  end,
})
