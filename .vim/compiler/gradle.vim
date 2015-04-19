if exists("current_compiler")
  finish
endif
let current_compiler = "gradle"

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:save_cpo = &cpo
set cpo-=C

CompilerSet makeprg=gradle\ --quiet
CompilerSet errorformat=
      \%f:%l:\ %m,
      \%-G:%.%#,
      \%-G%\\s%#,
      \%-GIncremental%.%#,
      \%-GBUILD\ SUCCESSFUL,
      \%-GTotal\ time:\ %.%#

      " \%E%f:\ %\\d%\\+:\ %m\ @\ line\ %l\\,\ column\ %c.,%-C%.%#,%Z%p^,
      " \%E%>%f:\ %\\d%\\+:\ %m,%C\ @\ line\ %l\\,\ column\ %c.,%-C%.%#,%Z%p^,
let &cpo = s:save_cpo
unlet s:save_cpo

