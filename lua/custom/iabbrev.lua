vim.cmd [[
  iabbrev PP PERF:<ESC>gcc^f:a
  iabbrev HH HACK:<ESC>gcc^f:a
  iabbrev TT TODO: @Jakub<ESC>gcc^fba
  iabbrev NN NOTE:<ESC>gcc^f:a
  iabbrev WW WARNING:<ESC>gcc^f:a
  iabbrev FF FIX:<ESC>gcc^f:a

  iabbrev CSSP content: '';<ESC>odisplay: block;<ESC>oposition: absolute;<ESC>otop: 0;<ESC>oright: 0;<ESC>o
  
  iabbrev iR import * as React from 'react'<ESC>a

  iabbrev tsi @ts-ignore<ESC>gcc
  iabbrev esi eslint-disable<ESC>gcc

  iabbrev rakuetn rakuten
  iabbrev rakuent rakuten
  iabbrev rakuten rakuten
  iabbrev cilent client
]]
