" Copyright (C) 2014 Andrea Cedraro <a.cedraro@gmail.com>
"
" Permission is hereby granted, free of charge, to any person obtaining
" a copy of this software and associated documentation files (the "Software"),
" to deal in the Software without restriction, including without limitation
" the rights to use, copy, modify, merge, publish, distribute, sublicense,
" and/or sell copies of the Software, and to permit persons to whom the
" Software is furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included
" in all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
" EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
" OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
" IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
" DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
" TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
" OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

hi! SimpleMarkWord1 ctermbg=6 ctermfg=Black
hi! SimpleMarkWord2 ctermbg=4 ctermfg=Black
hi! SimpleMarkWord3 ctermbg=2 ctermfg=Black
hi! SimpleMarkWord4 ctermbg=5 ctermfg=Black
hi! SimpleMarkWord5 ctermbg=3 ctermfg=Black
hi! SimpleMarkWord6 ctermbg=9 ctermfg=Black

let s:words = {}
let s:indexes = [1, 2, 3, 4, 5, 6]

function! s:nuke_item_with_index(i)
  for [word, item] in items(s:words)
    if item.index == a:i
      call matchdelete(item.mid)
      call remove(s:words, word)
    endif
  endfor
endfunction

function! s:available_index()
  if len(s:indexes) > 0
    return remove(s:indexes, 0)
  else
    return 1
  endif
endfunction

function! s:simplemark_clear_all()
  for [word, item] in items(s:words)
    call s:unmark_word(word)
  endfor
endfunction

function! s:unmark_word(word)
  let item = remove(s:words, a:word)
  call matchdelete(item.mid)
  call sort(add(s:indexes, item.index))
endfunction

function! s:simple_mark_word()
  let word = expand('<cword>')

  if has_key(s:words, word)
    call s:unmark_word(word)
  else
    let i = s:available_index()
    call s:nuke_item_with_index(i)

    let pattern = s:prepare_pattern(word)

    " Actually match the words.
    let s:words[word] = {}
    let s:words[word].mid = matchadd("SimpleMarkWord".i, pattern, 1)
    let s:words[word].index = i

    " Use the pattern as the current search so I can use n/N
    let @/ = pattern
  endif
endfunction

function! s:prepare_pattern(word)
  return '\V\<'.escape(a:word, '\').'\>'
endfunction

function! s:focus_marked_word(word)
  let @/ = s:prepare_pattern(a:word)
  normal! n
endfunction

nnoremap <silent> <Plug>(SimpleMark)      :call <SID>simple_mark_word()<cr>
nnoremap <silent> <Plug>(SimpleMarkClear) :call <SID>simplemark_clear_all()<cr>

function! s:marked_word(A,L,P)
  return keys(s:words)
endfunction
command! -nargs=1 -complete=customlist,s:marked_word MarkClear :call s:unmark_word(<f-args>)
command! -nargs=0 MarkClearAll :call s:simplemark_clear_all()
command! -nargs=1 -complete=customlist,s:marked_word MarkFocus :call s:focus_marked_word(<f-args>)
