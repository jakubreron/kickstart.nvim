vim.pack.add { 'https://github.com/stevearc/conform.nvim' }

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

vim.keymap.set('', '<leader>f', function()
  require('conform').format {
    async = true,
    lsp_format = 'never',
  }
end, { desc = '[f]ormat buffer' })
