" Set colorscheme, fonts and other graphical thing
if has('gui_running')
    set t_Co=256

    colorscheme solarized
    set background=dark

    if has('gui_gtk2')
        set guifont=ProggyCleanTTSZ\ for\ Powerline\ 12
    else
        set guifont=Anonymous\ Pro:h13
    endif
endif
