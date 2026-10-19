vim.pack.add {
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
}

local blocklist = {
  'fidget',
  'vimwiki',
  'blink-cmp-menu',
  'blink-cmp-documentation',
  'snacks_terminal',
  'snacks_win_backdrop',
  'oil',
  'snacks_layout_box',
  'snacks_picker_input',
  'snacks_picker_list',
  'snacks_picker_preview',
  'oil_preview',
  'man',
  'nvim-pack',
  'env',
  'lf',
  'text',
  'tmux',
  'mason_backdrop',
  'mason',
  'zip',
  'sshpublickey',
  'conf',
  'sshknownhosts',
  'systemd',
}

local function persist_blocklist(entry)
  local path = debug.getinfo(1, 'S').source:sub(2)
  local lines = vim.fn.readfile(path)
  local in_blocklist = false
  for i, line in ipairs(lines) do
    if line:match '^local blocklist = {' then
      in_blocklist = true
    elseif in_blocklist and line:match '^}' then
      table.insert(lines, i, "  '" .. entry .. "',")
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

-- run TSUpdate whenever nvim-treesitter is updated
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
      vim.cmd 'TSUpdate'
    end
  end,
})
