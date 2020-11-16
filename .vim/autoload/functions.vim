" Set tabstop, softtabstop and shiftwidth to the same value
function! functions#SetIndent(...)
  let l:tabstop = a:0 ? a:1 : 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
    if a:0 == 2 && a:2 =~? "x"
      setlocal expandtab
    endif
  endif
  try
    redraw
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction


function! functions#Expandtab(tabstop)
  let l:tabstop = a:tabstop
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
    setlocal expandtab
  endif
endfunction


function! functions#FollowSymlink()
  let orig_file = fnameescape(expand('%:p'))
  if getftype(orig_file) == 'link'
    let target_file = fnamemodify(resolve(orig_file), ':p')
    execute 'silent! file ' . fnameescape(target_file) . ' | e'
  endif
endfunction


function! functions#StripWhitespace(line1, line2)
  let save_cursor = getpos(".")
  let old_query   = getreg('/')
  execute printf('%d,%ds/\s\+$//e', a:line1, a:line2)
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction


function! functions#ScratchEdit(options)
  exe 'edit' tempname()
  setl buftype=nofile bufhidden=wipe nobuflisted
  if !empty(a:options) | exe 'setl' a:options | endif
endfunction


" stolen form Gary Bernhardt
function! functions#Rename()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    execute 'saveas' escape(new_name, ' ')
    execute 'silent !rm' escape(old_name, ' ')
    redraw!
  endif
endfunction


function! functions#Remove()
  let file = fnamemodify(bufname('%'),':p')
  bdelete!
  if !bufloaded(file) && delete(file)
    echoerr 'Failed to delete "'.file.'"'
  endif
endfunction
