local mini_ai_status_ok, mini_ai = pcall(require, 'mini.ai')
if mini_ai_status_ok then
  mini_ai.setup { n_lines = 500 }
end

local mini_bracketed_status_ok, mini_bracketed = pcall(require, 'mini.bracketed')
if mini_bracketed_status_ok then
  mini_bracketed.setup {
    buffer = { suffix = 'b', options = {} },
    comment = { suffix = '/', options = {} },
    conflict = { suffix = 'x', options = {} },
    file = { suffix = 'f', options = {} },
    indent = { suffix = 'i', options = {} },
    jump = { suffix = 'j', options = {} },
    location = { suffix = 'l', options = {} },
    oldfile = { suffix = 'o', options = {} },
    quickfix = { suffix = 'q', options = {} },

    -- TODO: @Jakub check
    treesitter = { suffix = '', options = {} },
    -- TODO: @Jakub check
    undo = { suffix = '', options = {} },

    window = { suffix = 'w', options = {} },
    yank = { suffix = 'y', options = {} },
  }
end

local hipatterns_status_ok, hipatterns = pcall(require, 'mini.hipatterns')
if hipatterns_status_ok then
  hipatterns.setup {
    highlighters = {
      -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
      fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
      hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
      todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
      note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

      -- Highlight hex color strings (`#rrggbb`) using that color
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  }
end

local mini_surround_status_ok, mini_surround = pcall(require, 'mini.surround')
if mini_surround_status_ok then
  mini_surround.setup {
    -- I liked tpope bindings more
    mappings = {
      add = 'ys', -- Add surrounding in Normal and Visual modes
      delete = 'ds', -- Delete surrounding
      find = ']s', -- Find surrounding (to the right)
      find_left = '[s', -- Find surrounding (to the left)
      replace = 'cs', -- Replace surrounding
      suffix_last = 'l', -- Suffix to search with "prev" method
      suffix_next = 'n', -- Suffix to search with "next" method

      -- unused / unnecessary
      update_n_lines = '', -- Update `n_lines`
      highlight = '', -- Highlight surrounding
    },

    -- Number of lines within which surrounding is searched
    n_lines = 50,
  }
end

local mini_animate_status_ok, mini_animate = pcall(require, 'mini.animate')
if mini_animate_status_ok then
  mini_animate.setup {
    cursor = {
      enable = true,
      timing = mini_animate.gen_timing.linear { duration = 85, unit = 'total' },
    },
    scroll = {
      enable = false,
    },
    -- scroll = {
    --   enable = true,
    --   timing = require('mini.animate').gen_timing.linear { duration = 75, unit = 'total' },
    -- },
    resize = {
      enable = false,
    },
    open = {
      enable = false,
    },
    close = {
      enable = false,
    },
  }

  -- disable scrolling on mouse since it's bugged with the smooth scroll plugin
  -- local scrolling_binds = {
  --   '<ScrollWheelUp>',
  --   '<S-ScrollWheelUp>',
  --   '<C-ScrollWheelUp>',
  --   '<ScrollWheelDown>',
  --   '<S-ScrollWheelDown>',
  --   '<C-ScrollWheelDown>',
  --   '<ScrollWheelLeft>',
  --   '<S-ScrollWheelLeft>',
  --   '<C-ScrollWheelLeft>',
  --   '<ScrollWheelRight>',
  --   '<S-ScrollWheelRight>',
  --   '<C-ScrollWheelRight>',
  -- }
  --
  -- for i = 1, #scrolling_binds do
  --   vim.keymap.set({ 'n', 'v', 'i' }, scrolling_binds[i], '<nop>')
  -- end
end

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
