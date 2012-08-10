fu! ToggleFold()
    if foldlevel('.') == 0
        normal! l
    else
        if foldclosed('.') < 0
            . foldclose
        else
            . foldopen
        endif
    endif
    echo
endf

" Map this function to Space key.
noremap <space> :call ToggleFold()<CR>
