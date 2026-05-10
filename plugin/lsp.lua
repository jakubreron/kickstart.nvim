vim.pack.add {
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/neovim/nvim-lspconfig',
}

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
    'hyprls',
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
