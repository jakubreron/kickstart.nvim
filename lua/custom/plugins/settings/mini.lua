require('mini.ai').setup { n_lines = 500 }

require('mini.bracketed').setup {
  comment = { suffix = '/', options = {} },

  treesitter = { suffix = '', options = {} },
  undo = { suffix = '', options = {} },
  window = { suffix = '', options = {} },
  yank = { suffix = '', options = {} },
}

local hipatterns = require 'mini.hipatterns'
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

require('mini.surround').setup {
  -- I liked tpope bindings more
  mappings = {
    add = 'ys', -- Add surrounding in Normal and Visual modes
    delete = 'ds', -- Delete surrounding
    replace = 'cs', -- Replace surrounding

    -- unused / unnecessary
    find = '', -- Find surrounding (to the right)
    find_left = '', -- Find surrounding (to the left)
    update_n_lines = '', -- Update `n_lines`
    highlight = '', -- Highlight surrounding
  },

  -- Number of lines within which surrounding is searched
  n_lines = 500,
}

require('mini.operators').setup {
  -- Evaluate text and replace with output
  evaluate = {
    prefix = 'g=',
  },

  -- [a]rrange text regions
  exchange = {
    prefix = 'ga',
    reindent_linewise = true, -- Whether to reindent new text to match previous indent
  },

  -- [m]ultiply (duplicate) text
  multiply = {
    prefix = 'gm',
    func = nil, -- Function which can modify text before multiplying
  },

  -- [s]wap text with register
  replace = {
    prefix = 'gs',
    reindent_linewise = true, -- Whether to reindent new text to match previous indent
  },

  sort = { prefix = '' },
}

require('which-key').add {
  { 'g=', desc = '[=]evaluate', icon = '' },
  { 'g==', desc = '[=]evaluate current line', icon = '' },

  { 'ga', desc = 'exch[a]nge text', icon = '' },
  { 'gaa', desc = 'exch[a]nge current line', icon = '' },

  { 'gm', desc = '[m]ultiply text', icon = '' },
  { 'gmm', desc = '[m]ultiply current line', icon = '' },

  { 'gs', desc = '[s]wap text', icon = '' },
  { 'gss', desc = '[s]wap current line', icon = '' },
}

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
