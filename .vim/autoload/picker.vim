function! picker#command(choice_command, vim_command)
  try
    call fugitive#repo()
    let choice_command = "git ls-files --others --cached --exclude-standard"
  catch
    let choice_command = a:choice_command
  endtry

  let selection = system(choice_command . " | picker -vim")
  redraw!
  if !v:shell_error
    execute a:vim_command selection
  endif
endfunction
