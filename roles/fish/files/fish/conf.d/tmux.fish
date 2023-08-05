function fzf_tmux_session2
    # oceanic-next colors to use in FZF
    # XXX(andrea): I'm not sure why but in iTerm2 I actually have a darker base00
    # than I have in neovim so use that. I'm not sure it is actually a bad idea
    # since it helps recognize neovim floating windows from tmux popups
    # XXX(andrea): If we start using fzf in the shell more we should just define
    # its config in the environment variable and be done with it.
    set --local iterm2_base00 "#19242B"
    set --local base01 "#343d46"
    set --local yellow "#FAC863"
    set --local purple "#C594C5"
    set --local red "#EC5F67"
    set --local green "#99c794"

    set --local results (tmux list-sessions -F "#{session_name}" | \
            /home/bigfix/.local/share/nvim/site/pack/packer/start/fzf/bin/fzf \
            --select-1 \
            --exit-0 \
            --print-query \
            --reverse \
            --color "gutter:$iterm2_base00,bg+:$base01,hl:$yellow,hl+:$yellow,prompt:$purple,pointer:$red,info:$green")
    set --local retval $status

    set --local query $results[1]

    if test $retval -eq 0
        set --local session $results[2]
        if test -z session
            set --local session $query
        end
        tmux switch-client -t $session
    else if test $retval -eq 1
        tmux command \
        -p "Press enter to create and go to [$query] session" \
        "run 'tmux new -d -s \"$query\"; tmux switch-client -t \"$query\"'"
    end
end

if not set -q TMUX
   and not set -q TESTING_FOR_PROPERLY_RUNNING_FISH
   and not set -q GOING_SSH_INTO_REMOTE_TMUX_SESSION
  tmux new -A -s main
end
