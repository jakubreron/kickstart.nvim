vim.pack.add { 'https://github.com/stevearc/conform.nvim' }

--- @type conform.FormatOpts
local format_after_save_opts = { lsp_format = 'never', async = true }

require('conform').setup {
  format_after_save = format_after_save_opts,
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

vim.keymap.set('', '<leader>f', function() require('conform').format(format_after_save_opts) end, { desc = '[f]ormat buffer' })
