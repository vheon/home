#!/usr/bin/env python3

import iterm2
import re
import argparse


parser = argparse.ArgumentParser(description='Change font size in the current iTerm2 session')
parser.add_argument('--size', default=13, dest='size', action='store')
args = parser.parse_args()

size = args.size

async def increase_font_size(connection):
    app = await iterm2.async_get_app(connection)
    # This regex splits the font into its name and size. Fonts always end with
    # their size in points, preceded by a space.
    r = re.compile(r'^(.* )\d*$')

    session=app.current_terminal_window.current_tab.current_session
    if not session:
        return

    # Get the session's profile because we need to know its font.
    profile = await session.async_get_profile()

    # Extract the name and point size of the font using a regex.
    font = profile.normal_font
    match = r.search(font)
    if not match:
        return
    groups = match.groups()
    name = groups[0]

    replacement = name + str(size)
    change = iterm2.LocalWriteOnlyProfile()
    change.set_normal_font(replacement)

    # Update the session's copy of its profile without updating the
    # underlying profile.
    await session.async_set_profile_properties(change)

iterm2.run_until_complete(increase_font_size)

