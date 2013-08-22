setlocal colorcolumn=

" Simpler way to navigate through 'tags'
nnoremap <buffer> <silent> <cr> <C-]>
nnoremap <buffer> <silent> <BS> <C-t>

" Move to the next/previous TextJump in help file
" TODO: consider the use of a text-obj plugin with text-obj-user
nnoremap <buffer> <silent> <C-n> :<C-U>call search('<Bar>[^<Bar>]\+<Bar>')<CR>
nnoremap <buffer> <silent> <C-p> :<C-U>call search('<Bar>[^<Bar>]\+<Bar>', 'b')<CR>
