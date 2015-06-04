if exists('g:loaded_text_object_entire')  "{{{1
  finish
endif
let g:loaded_text_object_entire = 1

function! s:select_a()
  " To easily back to the last position after a command.
  mark '
  keepjumps normal! gg0vG$
endfunction

function! s:select_i()
  " To easily back to the last position after a command.
  mark '

  keepjumps normal! gg0
  call search('^.', 'cW')
  normal! v
  keepjumps normal! G$
  call search('^.', 'bcW')
  normal! $
endfunction

onoremap <silent> ae :<C-U>call <SID>select_a()<cr><C-O>
xnoremap <silent> ae :<C-U>call <SID>select_a()<cr>
onoremap <silent> ie :<C-U>call <SID>select_i()<cr><C-O>
xnoremap <silent> ie :<C-U>call <SID>select_i()<cr>

