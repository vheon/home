" let b:surround_{char2nr(':')} = ":\r"
let b:surround_{char2nr('#')} = "#{\r}"

inoremap <buffer> <C-l> =>

" Define a text object for block arguments (do |...|)
onoremap <buffer> <silent> i\| :<c-u>normal! T\|vt\|<cr>
xnoremap <buffer> <silent> i\| :<c-u>normal! T\|vt\|<cr>
onoremap <buffer> <silent> a\| :<c-u>normal! F\|vf\|<cr>
xnoremap <buffer> <silent> a\| :<c-u>normal! F\|vf\|<cr>
