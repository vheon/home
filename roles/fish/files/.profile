# For some reason on some remote linux machine fishshell from linuxbrew is not
# accepted by `chsh`: I get a "/home/linuxbrew/.linuxbrew/bin/fish" does not
# exists. So we use the `.profile` file to replace the login shell process with
# `fish`.
# Idea taken from https://blog.liang2.tw/posts/2017/01/without-chsh/
export FISH_BIN="/home/linuxbrew/.linuxbrew/bin/fish"

# The replacement is only done in non-fish login interactive shell in
# SSH connection and fish executable exists.
if [ "$SHELL" != "$FISH_BIN" -a -n "$SSH_TTY" -a -x "$FISH_BIN" ] ; then
  # we first check whether fish can be executed, otherwise the
  # replacement will cause immediate crash at login (not fun)
  export TESTING_FOR_PROPERLY_RUNNING_FISH=1
  if "$FISH_BIN" -c 'echo "Test fish running" >/dev/null' ; then
    unset TESTING_FOR_PROPERLY_RUNNING_FISH
    export SHELL="$FISH_BIN"
    exec -l $SHELL -l
  else
    echo "Failed to launch fish shell. Go check its installation!"
    echo "Fall back to deault shell $SHELL ..."
  fi
fi
