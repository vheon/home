" Self made C-C, C-V. Just the few situation where I need
" Only for linux since on MacVim Cmd-C Cmd-V work out of the box
if !has("mac")
    nnoremap <C-a>  ggVG
    vnoremap <C-c>  "+y
    nnoremap <C-v>  "+gP
    inoremap <C-v>  <esc>"+gPa

    nnoremap <M-a>  ggVG
    vnoremap <M-c>  "+y
    vnoremap <M-v>  "+gP
    nnoremap <M-v>  "+gP
    inoremap <M-v>  <esc>"+gPa
endif
