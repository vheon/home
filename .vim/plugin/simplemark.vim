" Copyright (C) 2016 Andrea Cedraro <a.cedraro@gmail.com>
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

let s:words = {}
let s:free_indexes = range( 1, 6 )
let s:used_indexes = []

function! s:simplemark_clear_all()
  for word in keys(s:words)
    call s:unmark_word(word)
  endfor
endfunction

function! s:unmark_word(word)
  let marker = remove(s:words, a:word)
  call sort(add(s:free_indexes, marker.index))

  call s:windo('s:render_remove_mark', marker)
endfunction

function! s:render_remove_mark() dict
  call map(filter(getmatches(), "v:val.group =~# '".self.group."'"),
         \ 'matchdelete(v:val.id)')
endfunction

function! s:get_or_steal_index()
  if len(s:free_indexes) == 0
    call s:nuke_oldest_item()
  endif
  let index = remove(s:free_indexes, 0)
  call add(s:used_indexes, index)
  return index
endfunction

function! s:nuke_oldest_item()
  let index = remove(s:used_indexes, 0)
  for [word, marker] in items(s:words)
    if marker.index == index
      call s:unmark_word(word)
      return
    endif
  endfor
endfunction

function! s:add_mark(word)
  let index = s:get_or_steal_index()
  let pattern = s:prepare_pattern(a:word)
  let marker = {
        \ 'group': "SimpleMarkWord".index,
        \ 'pattern': pattern,
        \ 'index': index
        \ }
  let s:words[a:word] = marker

  " Use the pattern as the current search so I can use n/N
  let @/ = marker.pattern

  return marker
endfunction

function! s:render_add_mark() dict
  call matchadd(self.group, self.pattern, 10)
endfunction

function! s:mark_word(word)
  let marker = s:add_mark(a:word)
  call s:windo('s:render_add_mark', marker)
endfunction

function! s:windo(func, dict)
  let winnum = winnr()
  noautocmd windo call call(a:func, [], a:dict)
  execute 'noautocmd' winnum."wincmd w"
endfunction

function! s:simple_mark_word()
  let word = expand('<cword>')
  if word =~ '^\s*$'
    return
  endif

  if has_key(s:words, word)
    call s:unmark_word(word)
  else
    call s:mark_word(word)
  endif
endfunction

function! s:prepare_pattern(word)
  return '\V\<'.escape(a:word, '\/~ .*^[''$').'\>'
endfunction

function! s:focus_marked_word(word)
  let @/ = s:prepare_pattern(a:word)
  normal! n
endfunction

nnoremap <silent> <Plug>(SimpleMark)      :call <SID>simple_mark_word()<cr>
nnoremap <silent> <Plug>(SimpleMarkClear) :call <SID>simplemark_clear_all()<cr>

function! s:marked_word(A,L,P)
  return filter(keys(s:words), 'stridx(v:val, a:A) == 0' )
endfunction
command! -nargs=1 -complete=customlist,s:marked_word MarkClear
      \ :call s:unmark_word(<f-args>)
command! -nargs=0 MarkClearAll
      \ :call s:simplemark_clear_all()
command! -nargs=1 -complete=customlist,s:marked_word MarkFocus
      \ :call s:focus_marked_word(<f-args>)
