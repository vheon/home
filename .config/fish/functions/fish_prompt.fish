set -g __fish_git_prompt_showdirtystate 1
set -g __fish_git_prompt_showuntrackedfiles 1
set -g __fish_git_prompt_showstashstate 1

set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_dirtystate "!"
set -g __fish_git_prompt_char_untrackedfiles "…"

set -g __fish_git_prompt_char_cleanstate ""

set -g __fish_git_prompt_color_branch green
set -g __fish_git_prompt_color_dirtystate magenta
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_untrackedfiles cyan
set -g ___fish_git_prompt_color_merging magenta

function fish_prompt --description 'Write out the prompt'
	set -l last_status $status

	if test -n "$SSH_CONNECTION"
		echo -n (set_color green)"$USER"(set_color normal)"@"(set_color magenta)(hostname)" "
	end

	# PWD
	set_color blue
	echo -n (pwd|sed "s|$HOME|~|")
	set_color normal

	echo -n (__fish_git_prompt " (±)-[%s]")

	# New line
	echo

	if not test (count (jobs | grep "stopped")) -eq 0
		set_color yellow
		echo -n '☰ '
		set_color normal
	end

	if test $last_status = 0
		set_color green
	else
		set_color red
	end
	echo -n "❯ "
	set_color normal
end
