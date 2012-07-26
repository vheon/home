function! s:ToggleSolarized()
    ToggleBG
    let Powerline_colorscheme = ( &background == "dark"? "lightSolarized" : "darkSolarized" )
    PowerlineReloadColorscheme
endfunction

command! ToggleSolarized :call s:ToggleSolarized()
