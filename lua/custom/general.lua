local options = {
  dictionary = '/usr/share/dict/words',
  relativenumber = true,
  backup = false, -- creates a backup file
  -- completeopt = { "menuone", "noselect" },
  conceallevel = 0, -- so that `` is visible in markdown files
  -- hidden = true, -- required to keep multiple buffers and open multiple buffers
  pumheight = 10, -- pop up menu height
  -- smartindent = true, -- make indenting smarter again
  swapfile = false, -- creates a swapfile
  termguicolors = true, -- set term gui colors (most terminals support this)
  -- timeoutlen = 0, -- time to wait for a mapped sequence to complete (in milliseconds)
  -- title = true, -- set the title of window to the value of the titlestring
  -- opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  -- wrap = false, -- display lines as one long line
  laststatus = 3,
  lazyredraw = true, -- Don't redraw while executing macros (good performance config)
  linebreak = true, -- set linebreak on very long lines
  textwidth = 500, -- linebreak on 500 characters
  colorcolumn = '80',
  winbar = '%=%m %f',
}

-- vim.opt.path:append("**")
-- vim.opt.wildignore:append("*.o")
-- vim.opt.wildignore:append("*.pyc")
-- vim.opt.wildignore:append("*_build/*")
-- vim.opt.wildignore:append("**/coverage/*")
-- vim.opt.wildignore:append("**/node_modules/*")
-- vim.opt.wildignore:append("**/android/*")
-- vim.opt.wildignore:append("**/ios/*")
-- vim.opt.wildignore:append("**/.git/*")
-- vim.opt.wildignore:append("tags")

vim.opt.spelllang:append 'cjk' -- disable spellchecking for asian characters (VIM algorithm does not support it)
vim.opt.shortmess:append 'c' -- don't show redundant messages from ins-completion-menu
vim.opt.shortmess:append 'I' -- don't show the default intro message
vim.opt.whichwrap:append '<,>,[,],h,l'

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.b.match_words = '<<<<<<<:=======:>>>>>>>' -- match git conflict markers with %

-- use var for vimwiki home dir
vim.g.vimwiki_list = {
  {
    path = vim.fn.expand '$VIMWIKI_DIR',
    syntax = 'markdown',
    ext = '.md',
  },
}

-- do not wrap tmux
vim.g.tmux_navigator_no_wrap = 1

-- remove unnecessary unimpaired mappings
vim.g.nremap = {
  --tags
  ['[t'] = '',
  [']t'] = '',
  ['[T'] = '',
  [']T'] = '',

  -- url encode/decode
  ['[u'] = '',
  ['[uu'] = '',
  ['v_[u'] = '',
  [']u'] = '',
  [']uu'] = '',
  ['v_]u'] = '',

  -- XML encode/decode
  ['[x'] = '',
  ['[xx'] = '',
  ['v_[x'] = '',
  [']x'] = '',
  [']xx'] = '',
  ['v_]x'] = '',

  -- C string encode/decode
  ['[y'] = '',
  ['[yy'] = '',
  ['v_[y'] = '',
  ['[C'] = '',
  ['[CC'] = '',
  ['v_[C'] = '',
  [']y'] = '',
  [']yy'] = '',
  ['v_]y'] = '',
  [']C'] = '',
  [']CC'] = '',
  ['v_]C'] = '',
}
