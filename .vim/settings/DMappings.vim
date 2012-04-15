if has("gui_macvim")
    macmenu &File.New\ Tab key=<nop>
    map <D-t> :CommandT
else
    map <M-t> :CommandT
endif
