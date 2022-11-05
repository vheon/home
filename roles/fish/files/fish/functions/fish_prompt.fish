# catppuccin colors
set selection ff0000
set comment 00ff00

set foreground cdd6f4
set red f38ba8
set orange fab387
set yellow f9e2af
set green a6e3a1
set purple b4befe
set pink f5c2e7
set blue 89b4fa
set cyan 94e2d5

# Syntax Highlighting Colors
set -g fish_color_normal cdd6f4
set -g fish_color_command 89b4fa
set -g fish_color_param f2cdcd
set -g fish_color_keyword f38ba8
set -g fish_color_quote a6e3a1
set -g fish_color_redirection f5c2e7
set -g fish_color_end fab387
set -g fish_color_error f38ba8
set -g fish_color_gray 6c7086
set -g fish_color_selection --background=313244
set -g fish_color_search_match --background=313244
set -g fish_color_operator f5c2e7
set -g fish_color_escape f2cdcd
set -g fish_color_autosuggestion 6c7086
set -g fish_color_cancel f38ba8
set -g fish_color_cwd f9e2af
set -g fish_color_user 94e2d5
set -g fish_color_host 89b4fa

# # Completion Pager Colors
set -g fish_pager_color_progress 6c7086
set -g fish_pager_color_prefix f5c2e7
set -g fish_pager_color_completion cdd6f4
set -g fish_pager_color_description 6c7086

set -g __fish_git_prompt_showdirtystate 1
set -g __fish_git_prompt_showuntrackedfiles 1
set -g __fish_git_prompt_showstashstate 1

set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_dirtystate "!"
set -g __fish_git_prompt_char_untrackedfiles "…"

set -g __fish_git_prompt_char_cleanstate ""

set -g __fish_git_prompt_color_branch $green
set -g __fish_git_prompt_color_dirtystate $purple
set -g __fish_git_prompt_color_stagedstate $yellow
set -g __fish_git_prompt_color_invalidstate $red
set -g __fish_git_prompt_color_untrackedfiles $cyan
set -g ___fish_git_prompt_color_merging $purple

# Replace $HOME with "~"
function pwd_tilde_home --description 'short $HOME with ~'
    set --local realhome ~
    echo (string replace -r '^'"$realhome"'($|/)' '~$1' $PWD)
end

function fish_prompt
    set --local last_status $status

    set --local color_normal (set_color normal)

    # I'm in a tmux session I have the @machine is in the tmux status line.
    # No need to put it also in the prompt.
    if test -n "$SSH_CONNECTION" && test -z "$TMUX"
        set --local user_color (set_color $green)
        set --local hostname_color (set_color $purple)
        echo -n "$user_color$USER$color_normal@$hostname_color$hostname$color_normal "
    end

    # PWD
    set --local path_color (set_color $blue)
    set --local path (pwd_tilde_home)
    echo -n "$path_color$path$color_normal"

    # git + newline
    echo (__fish_git_prompt " \uE0A0 %s")

    if test (count (jobs | grep "stopped")) -ne 0
        set --local jobs_color (set_color $yellow)
        # XXX(andrea): right now this char is taking more than 1 cell space :?
        # which is why I also have a space after printing it...
        set --local jobs_char '☰'
        echo -n "$jobs_color$jobs_char$color_normal "
    end

    set --local prompt_char '❯'
    set --local prompt_char_color (set_color $green)
    if test $last_status -ne 0
        set prompt_char_color (set_color $red)
    end
    set --local nbs ' '
    echo -n "$prompt_char_color$prompt_char$color_normal$nbs"
end
