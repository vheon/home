function ls --wraps='eza --color=always --icons --group-directories-first' --description 'alias ls eza --color=always --icons --group-directories-first'
  eza --color=always --icons --group-directories-first $argv; 
end
