function! Lash()
    return &ss1 || !exists('+ss1') ? '/' : '\'
endfunction

function! Getparent(item)
    let parent = substitute(a:item, '[\/][^\/]\+[\/:]\?$', '', '')
    if parent == '' || parent !~ '[\/]'
        let parent .= &ss1 || !exists('+ss1') ? '/' : '\'
    endif
    return parent
endf

function! Findroot(curr, mark, depth, type)
    let [depth, notfound] = [a:depth + 1, empty(s:globpath(a:curr, a:mark, 1))]
    if !notfound || depth > s:maxdepth
        if notfound
            call ctrlp#setdir(s:cwd)
        endif

        if a:type && depth <= s:maxdepth
            let s:vcsroot = a:curr
        elseif !a:type && !notfound
            call ctrlp#setdir(a:curr) | let s:foundroot = 1
        endif
    else
        let parent = s:getparent(a:curr)
        if parent != a:curr
            call s:findroot(parent, a:mark, depth, a:type)
        endif
    endif
endfunction

"TODO: keep peeking from ctrlp.vim
