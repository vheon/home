if has('autocmd')

  " XXX: It's just to see if performance of re-sourcing vimrc improves
  if get(g:, 'vimrc_autocmd_loaded', 0)
    finish
  endif

  augroup cursor_line
    au!
    au BufEnter,WinEnter,InsertLeave * set cursorline
    au BufLeave,WinLeave,InsertEnter * set nocursorline
  augroup END

  augroup reload_specific_files
    au!
    " XXX: I'm trying to not resource it every time
    " au BufWritePost $MYVIMRC nested source $MYVIMRC
    " au BufWritePost ~/.vim/vimrc nested source ~/.vim/vimrc
    au BufWritePost solarized.vim color solarized
  augroup END

  " Enable omni completion
  " TODO: are these going to stay here?
  augroup omnifunc
    au!
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  augroup END

  augroup line_return
    au!
    au BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \   execute 'normal! g`"zvzz' |
          \ endif
  augroup END

  augroup shebang_chmod
  autocmd!
  autocmd BufNewFile   *  let b:brand_new_file = 1
  autocmd BufWritePost * unlet! b:brand_new_file
  autocmd BufWritePre  *
        \ if exists('b:brand_new_file') |
        \   if getline(1) =~ '^#!'      |
        \     let b:chmod_post = '+x'   |
        \   endif                       |
        \ endif

  autocmd BufWritePost,FileWritePost *
        \ if exists('b:chmod_post') && executable('chmod')      |
        \   silent! execute "!chmod ".b:chmod_post." '<afile>'" |
        \   unlet b:chmod_post                                  |
        \ endif
  augroup END

  augroup bundle_keyword
    au!
    au Syntax vim syn keyword vimCommand Bundle
  augroup END

  augroup fold_spoing
    " http://vim.wikia.com/wiki/Keep_folds_closed_while_inserting_text
    au!
    au InsertEnter *
          \ if !exists('w:last_fdm')       |
          \   let w:last_fdm = &foldmethod |
          \   setlocal foldmethod=manual   |
          \ endif

    au InsertLeave,WinLeave *
          \ if exists('w:last_fdm')          |
          \   let &l:foldmethod = w:last_fdm |
          \   unlet w:last_fdm               |
          \ endif
  augroup END

  augroup objc_ft
    au!
    au BufRead,BufNewFile *.m,*.mm set filetype=objc
  augroup END

  " Every ftplugin in macvim runtime file override this
  augroup formatoptions_o
    au!
    au BufRead * set formatoptions-=o
  augroup END

  let g:vimrc_autocmd_loaded = 1
endif

