return {
  {
    'stevearc/oil.nvim',
    lazy = false, -- needed to hijack netrw
    ft = 'netrw',
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      columns = {
        'icon',
        'size',
      },
      keymaps = {
        ['<C-l>'] = false, -- refresh
        ['<C-h>'] = false, -- horizontal split
        ['<C-s>'] = false, -- vertical split
        ['~'] = false, -- cwd to current dir (cannot change the case)
      },
      view_options = {
        show_hidden = true,
      },
      lsp_file_methods = {
        timeout_ms = 50000,
        autosave_changes = true,
      },
      git = {
        -- Return true to automatically git add/mv/rm files
        add = function()
          return true
        end,
        mv = function()
          return true
        end,
        rm = function()
          return true
        end,
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
