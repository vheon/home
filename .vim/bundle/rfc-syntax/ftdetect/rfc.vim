au BufRead,BufNewFile *.txt
            \ if expand('%:t') =~ 'rfc\d\+' |
            \   set filetype=rfc |
            \ endif
