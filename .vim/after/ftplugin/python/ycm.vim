if exists(":YcmCompleter") == 2
      \ && youcompleteme#SubCommandsComplete('','','') =~ 'GoToDefinitionElseDeclaration'

  nnoremap <buffer> gd :YcmCompleter GoToDefinitionElseDeclaration<cr>
endif

