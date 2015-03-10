" In vim the :Man command is defined in ftplugin/man.vim and is not loaded by
" default, so when other plugins need it they call 'runtime! ftplugin/man.vim'
" which cause this file to be sourced in the wrong buffer (the one that was
" focused when this was sourced) causing those settings to be applied to the
" wrong buffer too.
if &filetype == "man"
  setlocal colorcolumn=
  setlocal nolist

  nnoremap <buffer> q :q<cr>
endif
