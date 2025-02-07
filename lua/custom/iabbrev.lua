vim.cmd [[
  iabbrev PP PERF:<ESC>gcc^f:a
  iabbrev HH HACK:<ESC>gcc^f:a
  iabbrev TT TODO: @Jakub<ESC>gcc^fba
  iabbrev NN NOTE:<ESC>gcc^f:a
  iabbrev WW WARNING:<ESC>gcc^f:a
  iabbrev FF FIX:<ESC>gcc^f:a

  iabbrev tsi @ts-ignore<ESC>gcc
  iabbrev esi eslint-disable<ESC>gcc
]]
