-- Must be set BEFORE loading the plugin
vim.g.vimwiki_list = {
  {
    path = vim.fn.expand '$VIMWIKI_DIR',
    syntax = 'markdown',
    ext = '.md',
  },
}

vim.pack.add { 'https://github.com/vimwiki/vimwiki' }

vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = vim.fs.joinpath(vim.fn.expand '$VIMWIKI_DIR', 'diary', '*.md'),
  callback = function(event)
    local filename = vim.fn.fnamemodify(event.file, ':t:r')
    local y, m, d = filename:match '(%d%d%d%d)-(%d%d)-(%d%d)'

    -- ISO week number calculation via Lua
    local week_num = os.date('%V', os.time { year = y, month = m, day = d })

    vim.api.nvim_buf_set_lines(0, 0, -1, false, {
      '# ' .. filename .. ', Week ' .. week_num,
      '',
      '## To do',
      '',
      '* [ ] ',
      '',
      '## Notes',
      '',
      '* ...',
    })
  end,
})
