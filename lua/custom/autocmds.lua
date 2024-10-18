vim.api.nvim_create_autocmd('BufRead', {
  pattern = '*',
  command = 'normal g\'"',
})

-- NOTE: reload the buffer if it doesn't come from node_modules
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
  pattern = '*',
  callback = function()
    local bufname = vim.fn.expand '<afile>'
    if not string.match(bufname, 'node_modules') then
      vim.cmd 'checktime'
    end
  end,
})

-- NOTE: resize windows on tmux resize
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  command = 'wincmd =',
})

-- NOTE: performance settings
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*/node_modules/*' },
  callback = function(args)
    vim.diagnostic.disable(args.buf)

    vim.cmd 'setlocal noundofile'
    vim.cmd 'setlocal noautoindent'
    vim.cmd 'setlocal nosmartindent'
    vim.cmd 'setlocal undolevels=10'
    vim.cmd 'setlocal syntax=off'
    vim.cmd 'setlocal nofoldenable'
    vim.cmd 'setlocal buftype=nowrite'
    vim.cmd 'setlocal bufhidden=unload'

    vim.cmd 'TSBufDisable incremental_selection'
    vim.cmd 'TSBufDisable indent'
    vim.cmd 'TSBufDisable autotag'
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'neotest-output', 'neotest-output-panel', 'neotest-attach' },
  callback = function()
    vim.cmd 'norm G'
    vim.cmd 'setlocal number'
    vim.cmd 'setlocal relativenumber'
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'help',
  callback = function()
    vim.cmd 'setlocal number'
    vim.cmd 'setlocal relativenumber'
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'text', 'vimwiki' },
  callback = function()
    vim.cmd 'setlocal spell'
  end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.tfvars',
  command = 'setlocal filetype=tf',
})
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '.env*' },
  command = 'setlocal filetype=sh',
})

vim.api.nvim_create_autocmd({ 'VimLeave' }, {
  pattern = 'bm-*',
  command = '!shortcuts',
})

local auto_commit = function(type, scope, description)
  description = description or '⚙️ auto-commit changes'
  local commit = string.format('%s(%s): %s', type, scope, description)

  return string.format('git add .; git commit -m "%s"; git pull && git push;', commit)
end

vim.api.nvim_create_autocmd({ 'VimLeave' }, {
  pattern = vim.fn.expand '$VIMWIKI_DIR' .. '/**/*',
  callback = function()
    local filename = vim.fn.expand '%:t'
    vim.fn.jobstart(auto_commit('docs', 'vimwiki', filename), { detach = true })
  end,
})

vim.api.nvim_create_autocmd({ 'VimLeave' }, {
  pattern = {
    vim.fn.expand '$HOME' .. '/.config/shell/aliasrc*',
    vim.fn.expand '$HOME' .. '/.config/shell/profile*',
    vim.fn.expand '$HOME' .. '/.config/ticker/.ticker.yaml',
    'bm-*',
  },
  callback = function()
    local filename = vim.fn.expand '%:t'
    vim.fn.jobstart(auto_commit('config', filename), { detach = true })
  end,
})
