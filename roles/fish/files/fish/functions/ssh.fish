function __is_remote_machine
    return $status
end

function ssh --wraps='ssh' --description 'ssh that runs in a new windows outside of the local tmux session'
    cat ~/.ssh/config.d/remote_machines | string match --quiet "Host $argv[1]"
    if test $status -eq 0
        /Applications/iTerm.app/Contents/Resources/it2run open_new_window_no_tmux.py --remote $argv[1] --shell "$SHELL"
    else
        command ssh $argv
    end
end
