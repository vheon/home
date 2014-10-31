
function! picker#command(choice_command, picker_args, vim_command)
  try
    let selection = system(a:choice_command . " | picker " . a:picker_args)
  catch /Vim:Interrupt/
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction
