local status_ok, telescope = pcall(require, 'telescope')

if not status_ok then
  return
end

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ['<C-space>'] = require('telescope.actions').to_fuzzy_refine,

        ['<C-a>'] = { '<Home>', type = 'command' },
        ['<C-e>'] = { '<End>', type = 'command' },

        ['<C-j>'] = require('telescope.actions').cycle_history_next,
        ['<C-k>'] = require('telescope.actions').cycle_history_prev,
      },
    },
    path_display = {
      filename_first = {
        reverse_directories = false,
      },
    },
    scroll_strategy = 'limit',
    layout_strategy = 'vertical',
    layout_config = { height = 0.95 },
  },
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown(),
    },
    live_grep_args = {
      auto_quoting = true,
      mappings = {
        i = {
          ['<C-i>'] = require('telescope-live-grep-args.actions').quote_prompt,
          ['<C-g>'] = require('telescope-live-grep-args.actions').quote_prompt { postfix = ' --iglob ' },
          ['<C-s>'] = require('telescope-live-grep-args.actions').quote_prompt { postfix = ' --iglob *.test.*' },
        },
      },
    },
  },
}
