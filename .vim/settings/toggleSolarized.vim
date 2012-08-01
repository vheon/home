function! s:ToggleSolarized()
    let g:Powerline_colorscheme = ( &background == "dark"? "lightSolarized" : "darkSolarized" )
    ToggleBG
    PowerlineReloadColorscheme
endfunction

command! ToggleSolarized :call s:ToggleSolarized()
