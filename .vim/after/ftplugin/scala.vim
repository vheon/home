inoremap <buffer> <C-l> =>

nnoremap <buffer> <Leader>s
      \ :call selecta#command('files -i ''^(\.git\|\.hg\|\.svn\|_darcs\|\.brz)$\|target''', "", ":e")<cr>

