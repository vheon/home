if not set -q TESTING_FOR_PROPERLY_RUNNING_FISH && not set -q TMUX
  tmux new -A -s main
end
