
function! picker#command(choice_command, picker_args, vim_command)
  try
    call fugitive#repo()
    let choice_command = "git ls-files --others --cached --exclude-standard"
  catch
    let choice_command = a:choice_command
  endtry

  let selection = system(choice_command . " | picker -vim " . a:picker_args)
  redraw!
  if !v:shell_error
    exec a:vim_command selection
  endif
endfunction
