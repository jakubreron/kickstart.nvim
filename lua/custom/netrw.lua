-- TODO: refactor to lua
vim.cmd([[
  " Default to tree mode
  let g:netrw_liststyle=3
  let g:netrw_list_hide = &wildignore
  let g:netrw_keepdir = 0
  let g:netrw_localcopydircmd = 'cp -r'
  hi! link netrwMarkFile Search

  function! NetrwMapping()
    nmap <buffer> H u
    nmap <buffer> h -^
    nmap <buffer> l <CR>

    nmap <buffer> . gh
    nmap <buffer> P <C-w>z

    nmap <buffer> L <CR>:Lexplore<CR>
    nmap <buffer> <Leader>dd :Lexplore<CR>
  endfunction

  augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
  augroup END
]])
