vim.pack.add {
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
}

local blocklist = { 'fidget', 'vimwiki', 'blink-cmp-menu', 'blink-cmp-documentation' }

local function persist_blocklist(entry)
  local path = debug.getinfo(1, 'S').source:sub(2)
  local lines = vim.fn.readfile(path)
  for i, line in ipairs(lines) do
    if line:match '^local blocklist = {' then
      lines[i] = line:gsub('%s*}%s*$', ", '" .. entry .. "' }")
      break
    end
  end
  vim.fn.writefile(lines, path)
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function(args)
    if vim.list_contains(blocklist, args.match) then return end

    local lang = vim.treesitter.language.get_lang(args.match)
    if not lang then return end

    -- parser already installed, just turn on highlighting
    if vim.treesitter.language.add(lang) then
      vim.treesitter.start(args.buf)
      return
    end

    -- first time seeing this filetype: install the parser, then start highlighting once it's ready
    require('nvim-treesitter').install(lang):await(function(err)
      if not err and vim.treesitter.language.add(lang) then
        vim.treesitter.start(args.buf)
      else
        table.insert(blocklist, args.match)
        persist_blocklist(args.match)
      end
    end)
  end,
})
