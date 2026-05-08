vim.api.nvim_create_autocmd({ 'InsertEnter', 'CmdlineEnter' }, {
  once = true,
  callback = function()
    vim.pack.add {
      'https://github.com/rafamadriz/friendly-snippets',
      'https://github.com/saghen/blink.lib',
      'https://github.com/saghen/blink.cmp',
    }

    local cmp = require 'blink.cmp'
    cmp.build():wait(60000)

    cmp.setup {
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          buffer = { score_offset = -100 },
        },
      },
      cmdline = {
        completion = {
          menu = { auto_show = true },
        },
      },
      completion = {
        menu = {
          draw = {
            columns = {
              { 'kind_icon' },
              { 'label', 'label_description', gap = 1 },
              { 'kind' },
            },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 0,
        },
      },
    }
  end,
})
