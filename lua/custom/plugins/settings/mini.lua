local M = {}

M.config = function()
  -- Examples:
  --  - yinq - [Y]ank [I]nside [N]ext [']quote
  --  - dil{  - [D]elete [I]nside [L]ast [{]
  -- require('mini.ai').setup { n_lines = 500 }

  -- local mini_animate_status_ok, mini_animate = pcall(require, 'mini.animate')
  -- if mini_animate_status_ok then
  --   mini_animate.setup {
  --     cursor = {
  --       enable = true,
  --       timing = mini_animate.gen_timing.linear { duration = 85, unit = 'total' },
  --     },
  --     scroll = {
  --       enable = false,
  --     },
  --     -- scroll = {
  --     --   enable = true,
  --     --   timing = require('mini.animate').gen_timing.linear { duration = 85, unit = 'total' },
  --     -- },
  --     resize = {
  --       enable = false,
  --     },
  --     open = {
  --       enable = false,
  --     },
  --     close = {
  --       enable = false,
  --     },
  --   }
  --
  --   -- disable scrolling on mouse since it's bugged with the smooth scroll plugin
  --   -- local scrolling_binds = {
  --   --   '<ScrollWheelUp>',
  --   --   '<S-ScrollWheelUp>',
  --   --   '<C-ScrollWheelUp>',
  --   --   '<ScrollWheelDown>',
  --   --   '<S-ScrollWheelDown>',
  --   --   '<C-ScrollWheelDown>',
  --   --   '<ScrollWheelLeft>',
  --   --   '<S-ScrollWheelLeft>',
  --   --   '<C-ScrollWheelLeft>',
  --   --   '<ScrollWheelRight>',
  --   --   '<S-ScrollWheelRight>',
  --   --   '<C-ScrollWheelRight>',
  --   -- }
  --   --
  --   -- for i = 1, #scrolling_binds do
  --   --   vim.keymap.set({ 'n', 'v', 'i' }, scrolling_binds[i], '<nop>')
  --   -- end
  -- end

  local mini_operators_status_ok, mini_operators = pcall(require, 'mini.operators')
  if mini_operators_status_ok then
    mini_operators.setup {
      -- Evaluate text and replace with output
      evaluate = {
        prefix = 'g=',
      },

      -- e[x]change text regions
      exchange = {
        prefix = 'gx',
        -- Whether to reindent new text to match previous indent
        reindent_linewise = true,
      },

      -- [m]ultiply (duplicate) text
      multiply = {
        prefix = 'gm',
        -- Function which can modify text before multiplying
        func = nil,
      },

      -- [s]wap text with register
      replace = {
        prefix = 'gs',
        -- Whether to reindent new text to match previous indent
        reindent_linewise = true,
      },

      -- [a]rrange text
      sort = {
        prefix = 'ga',
        -- Function which does the sort
        func = nil,
      },
    }
  end

  -- local statusline = require 'mini.statusline'
  -- statusline.setup { use_icons = vim.g.have_nerd_font }

  -- You can configure sections in the statusline by overriding their
  -- default behavior. For example, here we set the section for
  -- cursor location to LINE:COLUMN
  ---@diagnostic disable-next-line: duplicate-set-field
  -- statusline.section_location = function()
  --   return '%2l:%-2v'
  -- end

  -- ... and there is more!
  --  Check out: https://github.com/echasnovski/mini.nvim
end

return M
