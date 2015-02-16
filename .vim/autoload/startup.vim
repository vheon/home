
function! startup#YCMInstall(info)
  if a:info.status == 'installed' || a:info.force
    !./install.sh --clang-completer
  endif
endfunction

function! startup#GoBinsInstall(info)
  if a:info.force
    call plug#load('vim-go')
    GoUpdateBinaries
  endif
endfunction
