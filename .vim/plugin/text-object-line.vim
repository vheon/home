" basically a clone of bruno-/vim-line
if exists('g:loaded_text_object_line')
  finish
endif
let g:loaded_text_object_line = 1


function! s:select_a()
  normal! m`
  keepjumps normal! 0v$
endfunction


function! s:select_i()
  normal! m`
  keepjumps normal! ^vg_
endfunction

" delete entire line but keep only the inner part in the register
function! s:delete_select_i(register)
  normal! m`
  execute 'keepjumps normal! ^vg_"'.a:register.'d'
  normal! "_dd
endfunction


onoremap <silent> al  :<C-U>call  <SID>select_a()<cr>
xnoremap <silent> al  :<C-U>call  <SID>select_a()<cr>
onoremap <silent> il  :<C-U>call  <SID>select_i()<cr>
xnoremap <silent> il  :<C-U>call  <SID>select_i()<cr>
nnoremap <silent> dil :<C-U> call <SID>delete_select_i(v:register)<cr>
