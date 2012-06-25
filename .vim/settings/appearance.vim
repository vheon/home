" Set colorscheme, fonts and other graphical thing
if has('gui_running')
    set t_Co=256

    colorscheme solarized
    set background=dark

    set guioptions-=T

    if has('gui_gtk2')
        set guifont=Anonymous\ Pro\ for\ Powerline\ 10
    else
        set guifont=Anonymous\ Pro\ for\ Powerline:h13
    endif
endif
