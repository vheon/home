setlocal commentstring=//\ %s

if exists(':YcmCompleter')
  nnoremap <buffer> <silent> gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
  nnoremap <buffer> <silent> gD :YcmCompleter GoToDeclaration<CR>
endif
