" Follow symlinks so we're editing the actual file instead of the symlink
" (change the value returned by %).

function! s:SwitchToActualFile()
    let fname = resolve(expand('%:p'))
    exec "edit! " . fname
    bwipeout #
endfunction
command FollowSymlink call s:SwitchToActualFile()
