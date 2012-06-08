if has("gui_macvim")

    " Command-T mapping

    macmenu &File.New\ Tab key=<nop>
    macmenu &Edit.Find.Find\.\.\. key=<nop>
    map <D-t> :CommandT

    " TComment mapping
    map <D-/> :TComment<cr>
    imap <D-/> <esc>:Tcomment<cr>i
else
    " Command-T mapping
    map <M-t> :CommandT<cr>

    " TComment mapping
    map <M-/> :TComment<cr>
    imap <M-/> <esc>:Tcomment<cr>i

    " NERDTree mapping (for mac this mapping is in gvimrc)
    map <M-f> :NERDTreeToggle<cr>
endif
