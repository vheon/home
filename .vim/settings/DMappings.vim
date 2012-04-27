if has("gui_macvim")
    macmenu &File.New\ Tab key=<nop>
    macmenu &Edit.Find.Find\.\.\. key=<nop>
    map <D-t> :CommandT
else
    map <M-t> :CommandT
endif
