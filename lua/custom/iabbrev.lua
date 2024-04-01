vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.js', '*.ts', '*.vue', '*.jsx', '*.tsx' },
  callback = function()
    vim.cmd [[
     function! Eatchar(pat)
       let char = nr2char(getchar(0))
       return (char =~ a:pat) ? '' : char
     endfunction

     iabbrev cl console.log()<Left><c-r>=Eatchar('\m\s\<bar>/')<CR>
     iabbrev cd console.debug()<Left><c-r>=Eatchar('\m\s\<bar>/')<CR>
   ]]
  end,
})
