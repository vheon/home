function! ctrlpline#main(...)
  return '%1* CtrlP %*['.a:5.']%=%<'.getcwd()
endfunction

