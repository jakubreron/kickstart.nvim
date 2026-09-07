vim.pack.add {
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
}

local blocklist = { 'fidget' }

vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function(args)
    if vim.list_contains(blocklist, args.match) then return end

    local lang = vim.treesitter.language.get_lang(args.match)

    if not lang then return end -- no treesitter parser exists for this filetype

    -- parser already installed, just turn on highlighting
    if vim.treesitter.language.add(lang) then
      vim.treesitter.start(args.buf)
      return
    end

    -- first time seeing this filetype: install the parser, then start highlighting once it's ready
    require('nvim-treesitter').install(lang):await(function(err)
      if not err and vim.treesitter.language.add(lang) then vim.treesitter.start(args.buf) end
    end)
  end,
})
