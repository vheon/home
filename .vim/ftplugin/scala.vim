inoremap <buffer> <C-l> =>

nnoremap <buffer> <Leader>s
      \ :call selecta#command("breadth-first-gfind * \| grep -v  target/", "", ":e")<cr>

