setlocal colorcolumn=121
setlocal textwidth=120
silent! iunmap <buffer> <CR>
inoremap <C-l> <C-o>:call Digraph()<cr>

function! Digraph()
  let col = col('.')
  let chars = getline('.')[ col - 2 : col - 1 ]
  execute "normal! s\<Esc>s\<C-K>".chars
endfunction
