vim.pack.add { 'https://github.com/folke/snacks.nvim' }

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
