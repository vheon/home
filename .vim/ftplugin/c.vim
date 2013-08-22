inoremap <buffer> <C-l> ->

if exists(":YcmCompleter") == 2
  nnoremap <silent> <buffer> gD :YcmCompleter GoToDefinitionElseDeclaration<CR>
endif
