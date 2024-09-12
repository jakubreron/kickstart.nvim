if string.find(vim.fn.expand '%:p', 'package.json') ~= nil then
  local current_buf = vim.api.nvim_get_current_buf()

  require('which-key').add {
    { '<leader>ln', desc = '[n]pm', icon = '' },
  }

  vim.keymap.set('n', '<leader>lna', '<cmd>lua require("package-info").install()<cr>', {
    buffer = current_buf,
    desc = '[A]dd',
  })

  vim.keymap.set('n', '<leader>lnd', '<cmd>lua require("package-info").delete()<cr>', {
    buffer = current_buf,
    desc = '[D]elete',
  })
  vim.keymap.set('n', '<leader>lnf', '<cmd>lua require("package-info").show({ force = true })<cr>', {
    buffer = current_buf,
    desc = '[F]etch',
  })
  vim.keymap.set('n', '<leader>lnh', '<cmd>lua require("package-info").hide()<cr>', {
    buffer = current_buf,
    desc = '[H]ide',
  })
  vim.keymap.set('n', '<leader>lnu', '<cmd>lua require("package-info").update()<cr>', {
    buffer = current_buf,
    desc = '[U]pdate',
  })
  vim.keymap.set('n', '<leader>lnr', '<cmd>lua require("package-info").reinstall()<cr>', {
    buffer = current_buf,
    desc = '[R]einstall all',
  })
  vim.keymap.set('n', '<leader>lnc', '<cmd>lua require("package-info").change_version()<cr>', {
    buffer = current_buf,
    desc = '[C]hange version',
  })
end
