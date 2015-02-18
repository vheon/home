" Shamelessly stolen from tommcdo
function! s:init_todo()
  highlight TodoCheckbox ctermfg=70
  highlight link TodoDone Comment

  call matchadd('TodoCheckbox', ' \zs✓\ze$')
  call matchadd('TodoDone', '\* \zs.*\ze ✓$')

  nmap <buffer> <C-K> $h"xC<C-R>=(@x==' ✓')?(''):(@x.' ✓')<CR><Esc>
endfunction

command! TodoList tabe ~/.todo.md | TabTitle TODO-LIST

autocmd BufRead,BufNewFile ~/.todo.md call s:init_todo()

