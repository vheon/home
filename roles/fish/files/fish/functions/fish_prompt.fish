# OceanicNext colors
set base00 1b2b34
set base01 343d46
set base02 4f5b66
set base03 65737e
set base04 a7adba
set base05 c0c5ce
set base06 cdd3de
set base07 d8dee9
set red ec5f67
set orange f99157
set yellow fac863
set green 99c794
set cyan 62b3b2
set blue 6699cc
set purple c594c5
set brown ab7967
set white ffffff

set -g fish_color_normal $white
set -g fish_color_command $white --bold
set -g fish_color_quote $green
set -g fish_color_redirection $cyan
set -g fish_color_end $purple
set -g fish_color_error $red --underline
set -g fish_color_param $base06
set -g fish_color_comment $base03 --italics
set -g fish_color_match $purple
set -g fish_color_selection $orange --inverse
set -g fish_color_search_match --background=$cyan
set -g fish_color_operator $blue
set -g fish_color_autosuggestion $base03

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
