return {
  {
    'stevearc/oil.nvim',
    lazy = false, -- needed to hijack netrw
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    ft = 'netrw',
    opts = {
      default_file_explorer = true,
      columns = {
        'icon',
        'size',
      },
      keymaps = {
        ['<C-l>'] = false, -- refresh
        ['<C-h>'] = false, -- horizontal split
        ['<C-s>'] = false, -- vertical split
        -- ['~'] = false, -- cwd to current dir (cannot change the case)
      },
      view_options = {
        show_hidden = true,
      },
      lsp_file_methods = {
        timeout_ms = 50000,
        autosave_changes = true,
      },
    },
    cmd = {
      'Oil',
    },
    keys = {
      {
        '-',
        '<cmd>Oil<cr>',
        desc = '[-] explorer',
      },
    },
  },
}
