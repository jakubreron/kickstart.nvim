if string.find(vim.fn.expand '%:p', 'package.json') ~= nil then
  local status_ok, which_key = pcall(require, 'which-key')
  if not status_ok then
    return
  end

  local opts = {
    mode = 'n',
    prefix = '<leader>',
    buffer = vim.api.nvim_get_current_buf(),
    silent = true,
    noremap = true,
    nowait = true,
  }

  local mappings = {
    l = {
      n = {
        name = '[n]pm',
        a = { "<cmd>lua require('package-info').install()<CR>", '[A]dd' },
        d = { "<cmd>lua require('package-info').delete()<CR>", '[D]elete' },
        f = { "<cmd>lua require('package-info').show({ force = true })<CR>", '[F]etch' },
        h = { "<cmd>lua require('package-info').hide()<CR>", '[H]ide' },
        u = { "<cmd>lua require('package-info').update()<CR>", '[U]pdate' },
        r = { "<cmd>lua require('package-info').reinstall()<CR>", '[R]einstall all' },
        c = { "<cmd>lua require('package-info').change_version()<CR>", '[C]hange version' },
      },
    },
  }

  which_key.register(mappings, opts)
end