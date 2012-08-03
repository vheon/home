" http://vimcasts.org/episodes/soft-wrapping-text/
function! s:WrappingToggle()
  if &wrap
      set nowrap nolinebreak list

      vunmap <D-j>
      vunmap <D-k>
      nunmap <D-j>
      nunmap <D-k>
  else
      set wrap linebreak nolist

      vmap <D-j> gj
      vmap <D-k> gk
      nmap <D-j> gj
      nmap <D-k> gk
  endif

endfunction


command! WrapToggle :call s:WrappingToggle()<cr>
