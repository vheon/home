#!/usr/bin/env python3

import iterm2
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('--remote', default='', dest='remote', action='store')
parser.add_argument('--shell', default='', dest='shell', action='store')

args = parser.parse_args()

async def main(connection):
    # This will run 'fish' from bash. If you use a different shell, you'll need
    # to change it here. Running it through the shell sets up your $PATH so you
    # don't need to specify a full path to the command.
    await iterm2.Window.async_create(connection, command = f"env GOING_SSH_INTO_REMOTE_TMUX_SESSION=1 {args.shell} -l -c 'command ssh {args.remote}'")

# Passing True for the second parameter means keep trying to
# connect until the app launches.
iterm2.run_until_complete(main, True)
