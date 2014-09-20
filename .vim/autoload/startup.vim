
function! startup#YCMInstall(info)
  if a:info.status == 'installed'
    !./install.sh --clang-completer
  endif
endfunction

function! startup#GoBinsInstall(info)
  call plug#load('vim-go')
  GoUpdateBinaries
endfunction
