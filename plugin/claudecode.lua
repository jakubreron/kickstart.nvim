vim.pack.add { 'https://github.com/coder/claudecode.nvim' }

require('claudecode').setup {
  ---@diagnostic disable-next-line: missing-fields
  diff_opts = { layout = 'unified' },
}

vim.keymap.set('n', '<leader>ac', '<cmd>ClaudeCode<cr>', { desc = 'Toggle Claude' })
vim.keymap.set('n', '<leader>af', '<cmd>ClaudeCodeFocus<cr>', { desc = 'Focus Claude' })
vim.keymap.set('n', '<leader>ar', '<cmd>ClaudeCode --resume<cr>', { desc = 'Resume Claude' })
vim.keymap.set('n', '<leader>aC', '<cmd>ClaudeCode --continue<cr>', { desc = 'Continue Claude' })
vim.keymap.set('n', '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', { desc = 'Add current buffer' })
vim.keymap.set('v', '<leader>as', '<cmd>ClaudeCodeSend<cr>', { desc = 'Send to Claude' })
vim.keymap.set('n', '<leader>as', '<cmd>ClaudeCodeTreeAdd<cr>', { desc = 'Add file' })
vim.keymap.set('n', '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', { desc = 'Accept diff' })
vim.keymap.set('n', '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', { desc = 'Deny diff' })
vim.keymap.set('n', '<leader>aD', '<cmd>ClaudeCodeCloseAllDiffs<cr>', { desc = 'Close all diffs' })
vim.keymap.set('n', '<leader>at', function()
  vim.ui.input({ prompt = 'Claude: ' }, function(text)
    if text and text ~= '' then
      vim.cmd.ClaudeCodeSendText(text)
    end
  end)
end, { desc = 'Send text to Claude' })
