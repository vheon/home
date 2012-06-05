" neocomplcache settings
"
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 3

" words less than 3 letters long aren't worth completing
let g:neocomplcache_auto_completion_start_length = 3

"
let g:neocomplcache_force_overwrite_completefunc = 1

" select the first option in the menu
"let g:neocomplcache_enable_auto_select = 1


inoremap <expr> <cr>    pumvisible() ? neocomplcache#close_popup() : "\<cr>"
inoremap <expr> jj      pumvisible() ? neocomplcache#close_popup() . "\<esc>" : "<esc>"
inoremap <expr> <esc>   pumvisible() ? neocomplcache#cancel_popup() : "\<esc>"
inoremap <expr> <C-j>   pumvisible() ? "\<C-n>" : "\<C-x>\<C-n>"
inoremap <expr> <C-k>   pumvisible() ? "\<C-p>" : "\<C-k>"
