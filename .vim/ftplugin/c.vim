inoremap <buffer> <C-l> ->

if exists(":YcmCompleter")
  nnoremap <silent> <buffer> gD :YcmCompleter GoToDefinitionElseDeclaration<CR>
endif
