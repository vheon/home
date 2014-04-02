if has('autocmd')

  " XXX: It's just to see if performance of re-sourcing vimrc improves
  if get(g:, 'vimrc_autocmd_loaded', 0)
    finish
  endif

  augroup cursor_line
    autocmd!
    autocmd BufEnter,WinEnter,InsertLeave * set cursorline
    autocmd BufLeave,WinLeave,InsertEnter * set nocursorline
  augroup END

  augroup reload_specific_files
    autocmd!
    " XXX: I'm trying to not resource it every time
    " autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
    " autocmd BufWritePost ~/.vim/vimrc nested source ~/.vim/vimrc
    autocmd BufWritePost solarized.vim color solarized
  augroup END

  augroup line_return
    autocmd!
    autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \   execute 'normal! g`"zvzz' |
          \ endif
  augroup END

  " Every ftplugin in macvim runtime file override this
  augroup formatoptions_o
    autocmd!
    autocmd FileType * setlocal formatoptions-=o
  augroup END

  " for profiling
  augroup profiling_vimrc
    autocmd!
    autocmd BufReadPost vim.profile setl ft=vim nolist
  augroup END

  augroup lcd_to_root_or_file
    autocmd!

    autocmd BufEnter *
          \ try                                         |
          \   execute 'lcd' '`=fugitive#repo().tree()`' |
          \ catch                                       |
          \ endtry
  augroup END

  augroup temp_prolog
    autocmd!
    autocmd BufNewFile,BufRead *.pl setlocal filetype=prolog
    autocmd Filetype prolog setl et sts=8 ts=8 sw=8
    autocmd Filetype prolog let b:start = 'swipl %' | let b:dispatch = b:start
    autocmd Filetype prolog nnoremap <buffer> <leader>t :w\|:Start<cr>
  augroup END

  let g:vimrc_autocmd_loaded = 1
endif

