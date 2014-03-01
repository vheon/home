"
" If definition is in the same file should just search for it withoud 'edit!'

function! s:_runtime_globpath(file)
  return split(globpath(escape(&runtimepath, ' '), a:file), "\n")
endfunction

function! s:_is_autoload_name(name)
  return matchstr(a:name, '\(\k\+#\)\+\k\+') == a:name
endfunction

function! s:_cursor_on_function_definition(name)
  return search('fu\%[nction]!\?\s\+\%['.a:name.']\%#', 'n') != 0
endfunction

function! s:_get_file_path_from_autoload_name(name)
  return 'autoload/'.fnamemodify(substitute(a:name, '#', '/', 'g'), ':h').'.vim'
endfunction

function! s:goto_definition(name)
  if s:_is_autoload_name(a:name)

    if s:_cursor_on_function_definition(a:name)
      return ''
    endif

    let path = s:_get_file_path_from_autoload_name(a:name)
    let real_path = get(s:_runtime_globpath(path), 0)

    if real_path =~ expand("%:p")
      " FIXME
      return 'call search(''fu\\%[nction]!\\?\\s\\+\\zs'.a:name.''')'
    else
      return 'edit! +call\ search(''fu\\%[nction]!\\?\\s\\+\\zs'.a:name.''') '.real_path
    endif
  endif

  return 'normal! gd'
endfunction
nnoremap <silent> <buffer> gd :execute <SID>goto_definition(expand("<cword>"))<cr>
