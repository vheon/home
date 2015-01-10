inoremap <buffer> <C-l> ->

if exists(':YcmCompleter')
  nnoremap <buffer> <silent> gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
  nnoremap <buffer> <silent> gD :YcmCompleter GoToDeclaration<CR>
endif

let &l:errorformat =
      \ '%E%f:%l:%c: fatal error: %m,' .
      \ '%E%f:%l:%c: error: %m,' .
      \ '%W%f:%l:%c: warning: %m,' .
      \ '%-G%\m%\%%(LLVM ERROR:%\|No compilation database found%\)%\@!%.%#,' .
      \ '%E%m'

setlocal commentstring=//\ %s
