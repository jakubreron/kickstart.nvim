local M = {}

M.config = function(bufnr)
  local ts_tools_status_ok = pcall(require, 'typescript-tools')
  if ts_tools_status_ok then
    local action_with_formatting = function(command)
      return function()
        vim.cmd(command)

        vim.defer_fn(function()
          require('conform').format { async = true, lsp_fallback = false }
        end, 250)
      end
    end

    local set_normal_keymap = function(keybind, command, desc)
      vim.keymap.set('n', keybind, command, {
        buffer = bufnr,
        desc = desc,
      })
    end

    set_normal_keymap('<leader>lio', action_with_formatting 'TSToolsOrganizeImports', '[o]rganize')
    set_normal_keymap('<leader>lis', action_with_formatting 'TSToolsSortImports', '[s]ort')
    set_normal_keymap('<leader>lir', action_with_formatting 'TSToolsRemoveUnusedImports', '[r]emove unused')
    set_normal_keymap('<leader>lia', action_with_formatting 'TSToolsAddMissingImports', '[a]dd missing')
  end
end

return M
