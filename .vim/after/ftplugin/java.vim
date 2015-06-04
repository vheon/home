setlocal colorcolumn=121
if exists(":PingEclim")
  nnoremap <buffer> gd :<c-u>JavaSearchContext -a edit<cr>
  " nnoremap <buffer> <c-t> :<c-u>JavaHierarchy<cr>
  nnoremap <buffer> gri   :<c-u>JavaImportOrganize<cr>
  nnoremap <buffer> K     :<c-u>JavaDocPreview<cr>
  nnoremap <buffer> <bs>  :<c-u>JavaCorrect<cr>
endif

compiler gradle
