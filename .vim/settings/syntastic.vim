" =============== Syntax chekers ===============

" use jshint as javascript syntax checker
let g:syntastic_javascript_cheker = 'jshint'


" ========== General Syntastic Settings ==========
" mark syntax errors with :sign
let g:syntastic_enable_sign = 1
" show the error list automatically
let g:syntastic_auto_loc_list = 1
" automatically jump to the first error when detected
let g:syntastic_auto_jump = 1
" TODO: test this option 
let g:syntastic_quiet_warnings = 1

" =============== Sign Color ===============

sign define SyntasticError texthl=SyntasticErrorSign
sign define SyntasticWarning texthl=SyntasticWarningSign
sign define SyntasticStyleError texthl=SyntasticErrorSign
sign define SyntasticStyleWarning texthl=SyntasticWarningSign
