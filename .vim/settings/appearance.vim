" Set colorscheme, fonts and other graphical thing
if has('gui_running')
    set t_Co=256

    colorscheme solarized
    set background=dark

    set guioptions-=T

    if has('gui_gtk2')
        " I love Anonymous pro, but ad 10pt sucks on my linuxbox monitor"
        " set guifont=Anonymous\ Pro\ for\ Powerline\ 10
        set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
    else
        set guifont=Anonymous\ Pro\ for\ Powerline:h12
    endif
endif
