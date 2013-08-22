if get(g:, 'vimrc_smartinputs_loaded', 0)
  finish
endif

call smartinput#map_to_trigger('i', '#', '#', '#')
call smartinput#define_rule({
      \ 'at':        '\%#',
      \ 'char':      '#',
      \ 'input':     '#{}<Left>',
      \ 'filetype':  ['ruby', 'coffee'],
      \ 'syntax':    ['Constant', 'Special'],
      \ })

call smartinput#define_rule({
      \ 'at':        '{\%#}',
      \ 'char':      '<Space>',
      \ 'input':     '<Space><Space><Left>',
      \ 'filetype':  ['ruby'],
      \ })

call smartinput#map_to_trigger('i', '<Bar>', '<Bar>', '<Bar>')
call smartinput#define_rule({
      \   'at':        '\({\|\<do\>\)\s*\%#',
      \   'char':      '<Bar>',
      \   'input':     '<Bar><Bar><Left>',
      \   'filetype':  ['ruby'],
      \ })
call smartinput#define_rule({
      \   'at':        '\({\|\<do\>\)\s*.\{-}\%#|',
      \   'char':      '<Bar>',
      \   'input':     '<Right>',
      \   'filetype':  ['ruby'],
      \ })

call smartinput#define_rule({
      \ 'at':        '\<do\%(\s*|.*|\)\=\s*\%#\s*$',
      \ 'char':      '<Enter>',
      \ 'input':     '<Enter>end<C-o>O',
      \ 'filetype':  ['ruby'],
      \ })

"FIXME: should use some function to check the existence of an end
function! Generic_enter(end)
  return "\<Enter>".a:end."\<C-o>O"
endfunction

call smartinput#define_rule({
      \ 'at':        '^\%(.*=\)\?\s*\%(module\|class\|def\|if\|unless\|case\|while\|until\|for\|begin\)\>\%(.*[^.:  @$]\<end\>\)\@!.*\%#',
      \ 'char':      '<Enter>',
      \ 'input':     '<C-r>=Generic_enter()<Enter>',
      \ 'filetype':  ['ruby'],
      \ })


call smartinput#define_rule({
      \ 'at': '^\s*aug\%[roup]\s\+\(END\|end\)\@!.*\%#',
      \ 'char': '<Enter>',
      \ 'input': '<C-r>=Generic_enter("augroup END")<Enter>',
      \ 'filetype': ['vim'],
      \ })
call smartinput#define_rule({
      \ 'at': '^\s*fu\%[nction].*\%#',
      \ 'char': '<Enter>',
      \ 'input': '<C-r>=Generic_enter("endfunction")<Enter>',
      \ 'filetype': ['vim'],
      \ })


" C/C++ Comment
call smartinput#map_to_trigger('i', '*', '*', '*')
call smartinput#define_rule({
      \ 'at':        '/\%#',
      \ 'char':      '*',
      \ 'input':     '*  */<Left><Left><Left>',
      \ 'filetype':  ['c', 'cpp'],
      \ })

call smartinput#define_rule({
      \ 'at':        '/\*\s\%#\s\*/',
      \ 'char':      '<Enter>',
      \ 'input':     '<BS><Del><Enter><BS><BS><Right><Up><Enter>',
      \ 'filetype':  ['c', 'cpp'],
      \ })

" Vim HashMap
call smartinput#define_rule({
      \ 'at':        '{\%#}',
      \ 'char':      '<Enter>',
      \ 'input':     '\\ <Left><Left><Left><Enter><Right><Enter><Up><Right><Right> ',
      \ 'filetype':  ['vim'],
      \ })

" Vim Multiline
call smartinput#define_rule({
      \ 'at': '\\.\{-},\%#',
      \ 'char': '<Enter>',
      \ 'input': '<Enter>\ ',
      \ 'filetype': ['vim'],
      \ })

" YCM test for python
call smartinput#map_to_trigger('i', '<Space>', '<Space>', '<Space>')
call smartinput#define_rule({
      \ 'at':        'from\%#',
      \ 'char':      '<Space>',
      \ 'input':     '<Space><C-X><C-O><C-P>',
      \ 'filetype':  ['python']
      \ })

call smartinput#define_rule({
      \ 'at':        'import\%#',
      \ 'char':      '<Space>',
      \ 'input':     '<Space><C-X><C-O><C-P>',
      \ 'filetype':  ['python']
      \ })

" YCM for call
call smartinput#define_rule({
      \ 'at':        'cal\%[l]\%#',
      \ 'char':      '<Space>',
      \ 'input':     '<Space><C-X><C-O><C-P>',
      \ 'filetype':  ['vim'],
      \ })

let g:vimrc_smartinputs_loaded = 1
