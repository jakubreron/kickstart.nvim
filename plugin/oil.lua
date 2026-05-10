vim.pack.add { 'https://github.com/stevearc/oil.nvim' }

require('oil').setup {
  columns = { 'icon', 'size' },
  keymaps = {
    ['<C-l>'] = false,
    ['<C-h>'] = false,
    ['~'] = false,
  },
  view_options = { show_hidden = true },
  lsp_file_methods = { timeout_ms = 15000 },
}

vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = '[-] explorer' })
