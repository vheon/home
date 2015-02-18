function! tabline#line()
  let tabnum = tabpagenr()
  let s = ''
  for i in range(1, tabpagenr('$'))
    " select the highlighting
    if i == tabnum
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif
    let numwin = tabpagewinnr(i, '$')
    if numwin > 1
      let s .= ' '.numwin
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%'.i.'T'

    let s .= ' %{tabline#label('.i.')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999Xclose'
  endif

  return s
endfunction

function! tabline#label(n)
  let title = gettabvar(a:n, 'tab_title')
  if title != ''
    return title
  else
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    let bufname = bufname(buflist[winnr - 1])
    if bufname == ''
      return '[No Name]'
    else
      return pathshorten(bufname)
    endif
  endif
endfunction

function! tabline#set_title(title, bang)
  if a:bang
    unlet! t:tab_title
  else
    let t:tab_title = a:title
    redraw!
  endif
endfunction
