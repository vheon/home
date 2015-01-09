nnoremap <silent> <buffer> ]] :call <SID>go_jump('/^\(func\)')<cr>
nnoremap <silent> <buffer> [[ :call <SID>go_jump('?^\(func\)')<cr>

" stolen from ftplugin/python.vim
function! s:go_jump(motion) range
  let cnt = v:count1
  let save = @/    " save last search pattern
  let wrapscan = &wrapscan
  set nowrapscan
  mark '
  while cnt > 0
    silent! exe a:motion
    let cnt = cnt - 1
  endwhile
  call histdel('/', -1)
  let &wrapscan = wrapscan
  let @/ = save    " restore last search pattern
endfunction
