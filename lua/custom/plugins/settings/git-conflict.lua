local status_ok = pcall(require, 'git-conflict')

if not status_ok then
  return
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'GitConflictDetected',
  callback = function()
    vim.notify('Conflict detected in ' .. vim.fn.expand '<afile>')

    require('conform').setup { format_on_save = nil }
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'GitConflictResolved',
  callback = function()
    vim.notify('Conflict resolved in ' .. vim.fn.expand '<afile>')

    require('conform').setup {
      format_on_save = {
        timeout_ms = 500,
        lsp_format = 'never',
      },
    }
  end,
})
