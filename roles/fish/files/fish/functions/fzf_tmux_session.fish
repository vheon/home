function fzf_tmux_session
    argparse 'n/new=' -- $argv
    if set -q _flag_new
        set --local query $_flag_new
        tmux new -d -s $query; and tmux switch-client -t $query
        return 0
    end

    set --local Normal "#1E1E2E"
    set --local CursorLine "#313244"
    set --local PreProc "#f38ba8"
    set --local Conditional "#cba6f7"
    set --local Exception "#f5e0dc"
    set --local String "#cba6f7"
    set --local Error "#f38ba8"

    set --local results (tmux list-sessions -F "#{session_name}" | \
            ~/.local/share/nvim/site/pack/packer/start/fzf/bin/fzf \
            --prompt "Sessions❯ " \
            --exit-0 \
            --print-query \
            --color "separator:$Error" \
            --color "gutter:$Normal" \
            --color "bg+:$CursorLine" \
            --color "hl:$PreProc" \
            --color "hl+:$PreProc" \
            --color "prompt:$Conditional" \
            --color "pointer:$Exception" \
            --color "info:$String")
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

