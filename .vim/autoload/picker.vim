
function! picker#command(choice_command, picker_args, vim_command)
  try
    call fugitive#repo()
    let choice_command = "git ls-files --others --cached --exclude-standard"
  catch
    let choice_command = a:choice_command
  endtry

  try
    let selection = system(choice_command . " | picker " . a:picker_args)
  catch /Vim:Interrupt/
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command selection
endfunction
