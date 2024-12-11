if string.find(vim.fn.expand '%:p', 'package.json') ~= nil then
  local bufnr = vim.api.nvim_get_current_buf()

  require('which-key').add {
    { '<leader>ln', desc = '[n]pm', icon = '' },
  }

  vim.keymap.set('n', '<leader>lna', '<cmd>lua require("package-info").install()<cr>', {
    buffer = bufnr,
    desc = '[a]dd',
  })

  vim.keymap.set('n', '<leader>lnd', '<cmd>lua require("package-info").delete()<cr>', {
    buffer = bufnr,
    desc = '[d]elete',
  })
  vim.keymap.set('n', '<leader>lnf', '<cmd>lua require("package-info").show({ force = true })<cr>', {
    buffer = bufnr,
    desc = '[f]etch',
  })
  vim.keymap.set('n', '<leader>lnh', '<cmd>lua require("package-info").hide()<cr>', {
    buffer = bufnr,
    desc = '[h]ide',
  })
  vim.keymap.set('n', '<leader>lnu', '<cmd>lua require("package-info").update()<cr>', {
    buffer = bufnr,
    desc = '[u]pdate',
  })
  vim.keymap.set('n', '<leader>lnr', '<cmd>lua require("package-info").reinstall()<cr>', {
    buffer = bufnr,
    desc = '[r]einstall',
  })
  vim.keymap.set('n', '<leader>lnc', '<cmd>lua require("package-info").change_version()<cr>', {
    buffer = bufnr,
    desc = '[c]hange version',
  })
end
