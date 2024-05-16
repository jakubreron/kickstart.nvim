vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.js', '*.ts', '*.vue', '*.jsx', '*.tsx' },
  callback = function()
    vim.cmd [[
     func Eatchar(pat)
        let c = nr2char(getchar(0))
        return (c =~ a:pat) ? '' : c
     endfunc

     iabbrev cl console.log()<Left><C-R>=Eatchar('\s')<CR>
     iabbrev cd console.debug()<Left><C-R>=Eatchar('\s')<CR>
   ]]
  end,
})

vim.cmd 'iabbrev PE PERF:<ESC>gccA'
vim.cmd 'iabbrev HK HACK:<ESC>gccA'
vim.cmd 'iabbrev TD TODO: @Jakub<ESC>gccA'
vim.cmd 'iabbrev NO NOTE:<ESC>gccA'
vim.cmd 'iabbrev WA WARNING:<ESC>gccA'
vim.cmd 'iabbrev FX FIX:<ESC>gccA'
