-- mini (must be first — other plugins rely on icons)
require('mini.icons').setup {}
require('mini.pairs').setup {}
require('mini.operators').setup {
  evaluate = { prefix = 'g=' },
  exchange = { prefix = 'ga', reindent_linewise = true },
  multiply = { prefix = 'gm', func = nil },
  replace = { prefix = 'gs', reindent_linewise = true },
  sort = { prefix = '' },
}

-- lazydev (lua LSP types — must load before lspconfig)
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  once = true,
  callback = function()
    require('lazydev').setup {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    }
  end,
})

-- mason stack
require('mason').setup {}
require('mason-tool-installer').setup {
  ensure_installed = {
    'lua-language-server',
    'typescript-language-server',
    'emmet-language-server',
    'bash-language-server',
    'tailwindcss-language-server',
    'stylelint-language-server',
    'json-lsp',
    'markdown-oxide',
    'html-lsp',
    'css-lsp',
    'eslint-lsp',
    'intelephense',
    'gopls',
    'sqls',
    'stylua',
    'biome',
    'markdownlint',
    'prettier',
    'prettierd',
  },
}
require('mason-lspconfig').setup { automatic_enable = true }

-- LSP
require 'lspconfig'

-- fidget (LSP progress UI)
require('fidget').setup {}

-- blink.cmp (completion)
require('blink.cmp').setup {
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

-- conform (formatting)
require('conform').setup {
  format_on_save = { lsp_format = 'never' },
  formatters_by_ft = {
    lua = { 'stylua' },
    javascript = { 'biome-check' },
    javascriptreact = { 'biome-check' },
    vue = { 'biome-check' },
    typescript = { 'biome-check' },
    typescriptreact = { 'biome-check' },
    css = { 'biome-check' },
    scss = { 'biome-check' },
    less = { 'biome-check' },
    sass = { 'biome-check' },
    html = { 'biome-check' },
    php = { 'prettier' },
    yaml = { 'prettierd' },
    json = { 'prettier' },
    markdown = { 'markdownlint' },
    vimwiki = { 'markdownlint' },
  },
}
vim.keymap.set('', '<leader>f', function() require('conform').format { async = true, lsp_format = 'never' } end, { desc = '[f]ormat buffer' })

-- treesitter
local ts_filetypes = {
  'bash',
  'c',
  'html',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'vim',
  'vimdoc',
  'diff',
  'tsx',
  'typescript',
  'comment',
  'javascript',
  'css',
  'scss',
  'vue',
  'json',
  'jsdoc',
  'yaml',
  'toml',
  'hyprlang',
  'regex',
  'query',
}
require('nvim-treesitter').install(ts_filetypes)
vim.api.nvim_create_autocmd('FileType', {
  pattern = { '*' },
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if lang and vim.treesitter.language.add(lang) then vim.treesitter.start(args.buf) end
  end,
})
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
      vim.cmd 'TSUpdate'
    end
  end,
})

-- snacks
require('snacks').setup {
  picker = {
    hidden = true,
    matcher = {
      frecency = true,
      history_bonus = true,
    },
    win = {
      input = {
        keys = {
          ['<C-k>'] = { 'history_back', mode = { 'i', 'n' } },
          ['<C-j>'] = { 'history_forward', mode = { 'i', 'n' } },
        },
      },
    },
  },
}

vim.keymap.set('n', '<leader>sb', function() Snacks.picker.buffers() end, { desc = '[b]uffers' })
vim.keymap.set('n', '<leader>sf', function() Snacks.picker.smart() end, { desc = '[f]iles' })
vim.keymap.set('n', '<leader>sd', function() Snacks.picker.diagnostics() end, { desc = '[d]iagnostic' })
vim.keymap.set('n', '<leader>svh', function() Snacks.picker.help() end, { desc = '[h]elp' })
vim.keymap.set('n', '<leader>svc', function() Snacks.picker.colorschemes() end, { desc = '[c]olorscheme' })
vim.keymap.set('n', '<leader>svk', function() Snacks.picker.keymaps() end, { desc = '[k]eymaps' })
vim.keymap.set('n', '<leader>st', function() Snacks.picker.grep() end, { desc = '[t]ext' })
vim.keymap.set('n', '<leader>sp', function() Snacks.picker.projects() end, { desc = '[p]rojects' })
vim.keymap.set('n', '<leader>sl', function() Snacks.picker.resume() end, { desc = '[l]ast resume' })
vim.keymap.set('n', '<leader>su', function() Snacks.picker.undo() end, { desc = '[u]ndo' })
vim.keymap.set('n', 'grd', function() Snacks.picker.lsp_definitions() end, { desc = '[d]efinition' })
vim.keymap.set('n', 'grt', function() Snacks.picker.lsp_type_definitions() end, { desc = '[t]ype definition' })
vim.keymap.set('n', 'grD', function() Snacks.picker.lsp_declarations() end, { desc = '[D]eclaration' })
vim.keymap.set('n', 'grr', function() Snacks.picker.lsp_references() end, { desc = '[r]eferences', nowait = true })
vim.keymap.set('n', 'gri', function() Snacks.picker.lsp_implementations() end, { desc = '[i]mplementation' })
vim.keymap.set('n', 'g0', function() Snacks.picker.lsp_symbols() end, { desc = 'LSP Symbols' })
vim.keymap.set('n', '<leader>gg', function() Snacks.lazygit() end, { desc = 'lazy[g]it' })
vim.keymap.set('n', '<leader>gb', function() Snacks.git.blame_line() end, { desc = '[b]lame line' })
vim.keymap.set('n', '<leader>gc', function() Snacks.picker.git_status() end, { desc = '[c]hanged files' })
vim.keymap.set('n', '<leader>gB', function() Snacks.picker.git_branches() end, { desc = '[B]ranches' })
vim.keymap.set('n', '<leader>gd', function() Snacks.picker.git_diff() end, { desc = '[d]iff' })
vim.keymap.set('n', '<leader>gla', function() Snacks.picker.git_log() end, { desc = '[a]ll' })
vim.keymap.set('n', '<leader>gll', function() Snacks.picker.git_log_line() end, { desc = '[l]ine' })
vim.keymap.set('n', '<leader>glf', function() Snacks.picker.git_log_file() end, { desc = '[f]ile' })
vim.keymap.set('n', '<C-q>', function() Snacks.picker.qflist() end, { desc = '[q]uickfix' })

-- gitsigns
require('gitsigns').setup {
  on_attach = function(bufnr)
    local gitsigns = require 'gitsigns'
    vim.keymap.set('n', ']c', function() gitsigns.nav_hunk 'next' end, { desc = 'next [g]it change', buffer = bufnr })
    vim.keymap.set('n', '[c', function() gitsigns.nav_hunk 'prev' end, { desc = 'prev git [c]hange', buffer = bufnr })
    vim.keymap.set('n', '<leader>gs', function() gitsigns.stage_hunk() end, { desc = 'git [s]tage hunk' })
    vim.keymap.set('n', '<leader>gr', function() gitsigns.reset_hunk() end, { desc = 'git [r]eset hunk' })
    vim.keymap.set('n', '<leader>gS', function() gitsigns.stage_buffer() end, { desc = 'git [S]tage buffer' })
    vim.keymap.set('n', '<leader>gR', function() gitsigns.reset_buffer() end, { desc = 'git [R]eset buffer' })
    vim.keymap.set('n', '<leader>gp', function() gitsigns.preview_hunk() end, { desc = 'git [p]review hunk' })
  end,
}

-- ts-comments
vim.api.nvim_create_autocmd('BufReadPost', {
  once = true,
  callback = function() require('ts-comments').setup {} end,
})

-- boole
vim.api.nvim_create_autocmd('BufReadPost', {
  once = true,
  callback = function()
    require('boole').setup {
      mappings = {
        increment = '<C-a>',
        decrement = '<C-x>',
      },
      additions = {
        { 'child', 'parent' },
        { 'toBeTruthy', 'toBeFalsy' },
        { 'toBeEnabled', 'toBeDisabled' },
        { 'left', 'center', 'right' },
        { 'light', 'dark' },
      },
    }
  end,
})

-- oklch color picker
vim.keymap.set('n', '<leader>c', function()
  if not package.loaded['oklch-color-picker'] then require('oklch-color-picker').setup {} end
  require('oklch-color-picker').pick_under_cursor()
end, { desc = 'Color pick under cursor' })

-- neotest
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'neotest-output', 'neotest-output-panel', 'neotest-attach' },
  callback = function()
    vim.cmd 'norm G'
    vim.opt_local.number = true
    vim.opt_local.relativenumber = true
  end,
})

local neotest_configured = false
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'javascript', 'typescript', 'typescriptreact' },
  callback = function(event)
    local neotest = require 'neotest'
    if not neotest_configured then
      neotest_configured = true
      neotest.setup {
        summary = { open = 'topleft vsplit | vertical resize 50' },
        output_panel = { enabled = true, open = 'rightbelow vsplit | resize 75' },
        adapters = {
          require 'neotest-jest' {},
          require 'neotest-vitest' {},
        },
      }
    end

    local set_keymap = function(keybind, command, desc) vim.keymap.set('n', keybind, command, { buffer = event.buf, desc = desc }) end

    set_keymap(']u', function() neotest.jump.next { status = 'failed' } end, 'next failed [u]nit test')
    set_keymap('[u', function() neotest.jump.prev { status = 'failed' } end, 'previous failed [u]nit test')
    set_keymap('<leader>ur', function()
      neotest.output_panel.clear()
      neotest.run.run()
    end, '[r]un nearest')
    set_keymap('<leader>uf', function()
      neotest.output_panel.clear()
      neotest.run.run(vim.fn.expand '%')
    end, 'run [f]ile')
    set_keymap('<leader>ul', function()
      neotest.output_panel.clear()
      neotest.run.run_last()
    end, 'run [l]ast')
    set_keymap('<leader>uc', function()
      neotest.summary.toggle()
      neotest.output_panel.toggle()
    end, '[c]ombo: summary tree + output panel')
    set_keymap('<leader>us', function() neotest.run.stop() end, '[s]top')
    set_keymap('<leader>ut', function() neotest.summary.toggle() end, 'summary [t]ree')
    set_keymap('<leader>uw', function() neotest.watch.toggle(vim.fn.expand '%') end, '[w]atch file')
    set_keymap('<leader>ua', function() neotest.run.attach() end, '[a]ttach')
    set_keymap('<leader>up', function() neotest.output_panel.toggle() end, '[p]anel toggle')
    set_keymap('<leader>uo', function() neotest.output.open { enter = true } end, '[o]utput')
    set_keymap('<leader>uR', function() neotest.summary.run_marked() end, '[R]un marked')
    set_keymap('<leader>uL', function()
      local last = neotest.run.get_last_run()
      if last then vim.notify(vim.inspect(last), vim.log.levels.INFO, { title = 'neotest last run' }) end
    end, 'show [L]ast run info')
  end,
})

-- vim-obsession (session saving)
vim.keymap.set('n', '<leader>ot', '<cmd>Obsession<cr>', { desc = '[t]rack session' })
vim.keymap.set('n', '<leader>oT', ':Obsession Session-.vim<Left><Left><Left><Left>', { desc = '[T]rack custom session' })
vim.keymap.set('n', '<leader>os', '<cmd>source Session.vim<cr>', { desc = '[s]ource session' })
vim.keymap.set('n', '<leader>oS', ':source Session-', { desc = '[S]ource custom session' })

-- oil
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

-- nvim-spectre
local function load_spectre()
  require('spectre').setup {
    replace_engine = {
      ['sed'] = {
        cmd = 'sed',
        args = { '-i', '', '-E' },
      },
    },
  }
end

vim.keymap.set('n', '<leader>ra', function()
  if not package.loaded['spectre'] then load_spectre() end
  require('spectre').open()
end, { desc = '[a]ll' })
vim.keymap.set('n', '<leader>ru', function()
  if not package.loaded['spectre'] then load_spectre() end
  require('spectre').open_visual { select_word = true }
end, { desc = '[u]nder cursor' })

-- treesj
local function load_treesj() require('treesj').setup { use_default_keymaps = false } end

vim.keymap.set('n', 'gJ', function()
  if not package.loaded['treesj'] then load_treesj() end
  vim.cmd 'TSJJoin'
end, { desc = '[J]oin' })
vim.keymap.set('n', 'gS', function()
  if not package.loaded['treesj'] then load_treesj() end
  vim.cmd 'TSJSplit'
end, { desc = '[S]plit' })

-- nvim-surround
vim.api.nvim_create_autocmd('BufReadPost', {
  once = true,
  callback = function() require('nvim-surround').setup {} end,
})

-- claudecode
require('claudecode').setup {}

vim.keymap.set('n', '<leader>ac', '<cmd>ClaudeCode<cr>', { desc = 'Toggle Claude' })
vim.keymap.set('n', '<leader>af', '<cmd>ClaudeCodeFocus<cr>', { desc = 'Focus Claude' })
vim.keymap.set('n', '<leader>ar', '<cmd>ClaudeCode --resume<cr>', { desc = 'Resume Claude' })
vim.keymap.set('n', '<leader>aC', '<cmd>ClaudeCode --continue<cr>', { desc = 'Continue Claude' })
vim.keymap.set('n', '<leader>am', '<cmd>ClaudeCodeSelectModel<cr>', { desc = 'Select Claude model' })
vim.keymap.set('n', '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', { desc = 'Add current buffer' })
vim.keymap.set('v', '<leader>as', '<cmd>ClaudeCodeSend<cr>', { desc = 'Send to Claude' })
vim.keymap.set('n', '<leader>as', '<cmd>ClaudeCodeTreeAdd<cr>', { desc = 'Add file' })
vim.keymap.set('n', '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', { desc = 'Accept diff' })
vim.keymap.set('n', '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', { desc = 'Deny diff' })

-- vimwiki
vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = '**/diary/*.md',
  callback = function(event) vim.cmd('silent 0r !~/.local/bin/generate-vimwiki-diary-template ' .. vim.fn.shellescape(event.file)) end,
})

-- package-info
vim.api.nvim_create_autocmd('BufRead', {
  pattern = 'package.json',
  once = true,
  callback = function() require('package-info').setup {} end,
})
