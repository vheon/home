function fzf_tmux_session
    argparse 'n/new=' -- $argv
    if set -q _flag_new
        set --local query $_flag_new
        tmux new -d -s $query; and tmux switch-client -t $query
        return 0
    end

    # oceanic-next colors to use in FZF
    # XXX(andrea): I'm not sure why but in iTerm2 I actually have a darker base00
    # than I have in neovim so use that. I'm not sure it is actually a bad idea
    # since it helps recognize neovim floating windows from tmux popups
    # XXX(andrea): If we start using fzf in the shell more we should just define
    # its config in the environment variable and be done with it.
    # set --local Normal "#152528"
    # set --local CursorLine "#254147"
    # set --local PreProc "#d38d97"
    # set --local Conditional "#b97490"
    # set --local Exception "#EC5F67"
    # set --local String "#99c794"
    set --local Normal "#1E1E2E"
    set --local CursorLine "#313244"
    set --local PreProc "#f38ba8"
    set --local Conditional "#cba6f7"
    set --local Exception "#f5e0dc"
    set --local String "#cba6f7"

    set --local results (tmux list-sessions -F "#{session_name}" | \
            /home/bigfix/.local/share/nvim/site/pack/packer/start/fzf/bin/fzf \
            --prompt "Sessions❯ " \
            --exit-0 \
            --print-query \
            --color "gutter:$Normal,bg+:$CursorLine,hl:$PreProc,hl+:$PreProc,prompt:$Conditional,pointer:$Exception,info:$String")
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
        "run 'fish -c \"fzf_tmux_session --new $query\"'"
    end
end

