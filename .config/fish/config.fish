set -x EDITOR vim

# Use my GPG key
set -gx GPG_TTY (tty)

# Base16 Shell
if status --is-interactive
  eval sh $HOME/.config/base16-shell/scripts/base16-default-dark.sh
end

set multiplier "1.25"

# Base16 Shell
if status --is-interactive
	eval sh $HOME/.config/base16-shell/scripts/base16-summerfruit-dark.sh
	# eval sh $HOME/.config/base16-shell/scripts/base16-pico.sh
end

alias wgrep "grep -Prn --color=always --exclude-dir=.svn --exclude-dir=.git"
alias nz "nz a -r -y -nm -m.5g -co"
alias dockercleanup "/bin/bash ~/scripts/pc/cleanup_docker.sh"

# Makes the aliases carry into the sudo environment
# -E just preserv env. It's not really
# necessary, but may be useful.
function sudo
	command sudo -sE $argv
end

# Hijack the git command
function git
	if echo "$argv[1]" | grep "mergeto" > /dev/null
		set startingbranch (git branch | grep -E "^\* " | awk '{print $2}')
		set targetbranch "$argv[2]"

		echo "Merging $startingbranch into $targetbranch"

		git co $targetbranch
		git pull --rebase
		git merge $startingbranch
		git push
		# If the failed (had conflicts) git co will also fail, I am assuming the same for rebase above
		git co $startingbranch
	else
		command git $argv
	end
end

function memusage
	smem -t -P $argv
	smem -t -k -c pss -P $argv | tail -n 1
end

function dgrep
	# grep -Rl --exclude-dir=.svn --exclude-dir=.git "$argv[1]" $argv[2..-1] | xargs vim
	grep -Rl --exclude-dir=.svn --exclude-dir=.git "$argv[1]" $argv[2..-1] | xargs geany -t 2>&1 &
end

function kgrep
	ps ax | grep $argv[1]
	# uses the first parameter as the grep param and the rest as kill params so we can do a -9 if needed
	ps ax | grep $argv[1] | awk '{print $argv[1]}' | xargs kill #$argv[2..-1]
end

# Shortcut function for taskwarrior, timewarrior and bugwarrior
# Also provides "t 3010 note" which opens an editor so I can write my notes to attach to the issue
# function t
# 	set argc (count $argv)
# 	set t_origredmineid ""
# 	set t_redmineid ""
# 	set t_cmd ""
# 	set t_outcmd ""

# 	# Check if the first argument is numeric
# 	# If so, get the proper taskwarrior selector from the redmine id
# 	# If not, we either may be
# 	# 	A. running a function not requiring an id 
# 	# 	B. running a function on whatever task is currently started
# 	# 	C. running a function on the most previous task
# 	if echo "$argv[1]" | grep -E "^[0-9]+\$" > /dev/null
# 		set t_origredmineid "$argv[1]"
# 		# If we've defined a function on the redmine id
# 		if math "$argc > 1" | grep "1" > /dev/null
# 			set t_cmd $argv[2]
# 		end
# 		# echo "1) set redmine id = $t_redmineid"
# 		# echo "1) set cmd = $t_cmd"
# 	else
# 		set t_origredmineid (timew | grep -oP "\(bw\)Is#\K[0-9]+" -)
# 		set t_cmd $argv[1]
# 		# echo "2) set redmine id = $t_redmineid"
# 		# echo "2) set cmd = $t_cmd"
# 	end

# 	set t_redmineid "redmineid:$t_origredmineid"

# 	# Commands not requiring a redmineid
# 	if echo "$t_cmd" | grep "update" > /dev/null
# 		set t_outcmd "bugwarrior-pull"
# 	# Commands requiring a redmine id
# 	else if echo "$t_redmineid" | grep -E "[0-9]+\$" > /dev/null
# 		# Attach a note
# 		if echo "$t_cmd" | grep "note" > /dev/null
# 			set t_outcmd "vipe <&- | sed -E \"s/\\\$/\\\\\\\\/g\" | xargs -0 task $t_redmineid annotate"
# 		else if echo "$t_cmd" | grep "elapsed" > /dev/null
# 			set my_starttime (timew | grep "Started" | awk '{print $2}' | date +"%s" -f -); \
# 			set my_curtime (date +"%s"); \
# 			set my_elapsed (math "$my_curtime - $my_starttime"); \
# 			# echo "3) Elapsed Time: $my_elapsed secs"
# 			echo "$my_elapsed"
# 			if math "$my_elapsed > 0" | grep "1" > /dev/null
# 				return 0
# 			else
# 				return 1
# 			end
# 		# Override "start" to automatically stop the previous task?
# 		else if echo "$t_cmd" | grep "start" > /dev/null; and t elapsed > /dev/null
# 			echo "Task already started, closing old task!"
# 			t stop
# 			t $argv[1..-1] :adjust
# 			return $status
# 		# Override "stop" to get the current time, stop the task, then multiply the time!
# 		else if echo "$t_cmd" | grep "stop" >dev/null; and t elapsed > /dev/null
# 			set elapsed (t elapsed)
# 			set adjusted (math "$elapsed * $multiplier")
# 			set adjusted (math "$adjusted - $adjusted % 1" | cut -d'.' -f1)
# 			set adjustment (math "$adjusted - $elapsed")

# 			echo "Elapsed  time: $elapsed""s"
# 			echo "Adjusted time: $adjusted""s"
# 			echo "Difference   : $adjustment""s"

# 			set t_timewid (timew summary 1s ago :id | grep -R "(bw)Is#[0-9]*" - | awk "{print \$4}" | tail -c +2)

# 			# task $t_redmineid stop

# 			# Should simply write my own time logs that have the date, redmine_id, time (in seconds), notes
# 			# Can't start a new task 
# 			echo (date +"%Y-%m-%d")"	#$t_origredmineid	$adjusted	notesnotesnotes" >> ~/.timewarrior/ondantime.log
# 			# timew lengthen @$t_timewid $adjustment :adjust

# 			return $status
# 		#######################################
# 		#######################################
# 		####### END OF CUSTOM COMMANDS ########
# 		#######################################
# 		#######################################
# 		# Catch and forward the command to taskwarrior as is (with the current redmineid if any)
# 		else if math "$argc > 1" | grep "1" > /dev/null
# 			set t_outcmd "task $t_redmineid $argv[2..-1]"
# 		else
# 			set t_outcmd "task $t_redmineid"
# 		end
# 	else
# 		if echo "$t_cmd" | grep "note" > /dev/null
# 			echo "No task defined to add a note to!" > /dev/stderr
# 			return 1;
# 		else if echo "$t_cmd" | grep "elapsed" > /dev/null
# 			echo "0"
# 			return 1;
# 		#######################################
# 		#######################################
# 		####### END OF CUSTOM COMMANDS ########
# 		#######################################
# 		#######################################
# 		# Now forward to taskwarrior		
# 		else if math "$argc > 0" | grep "1" > /dev/null
# 			set t_outcmd "task $t_redmineid $argv[1..-1]"
# 		else
# 			set t_outcmd "task $t_redmineid"
# 		end
# 	end

# 	# echo "$t_outcmd"
# 	/bin/fish -c "$t_outcmd"

# 	return $status
# end

# If you decide to set fish as your default shell, you may find that you no longer have very much in your path. You can add a section to your  ~/.config/fish/config.fish file that will set your path correctly on login.
if status --is-login
	set PATH $PATH /usr/bin /sbin
end

set -q __fish_prompt_hostname

function fish_user_key_bindings
	# https://github.com/fish-shell/fish-shell/blob/master/doc_src/bind.txt
	# Execute this once per mode that emacs bindings should be used in
	fish_default_key_bindings -M insert
	# Without an argument, fish_vi_key_bindings will default to
	# resetting all bindings.
	# The argument specifies the initial mode (insert, "default" or visual).
	fish_vi_key_bindings insert

	# when starting fish from tmux...
	# So ctrl left-arrow and right arrow work in insert mode
	bind -M insert \e\[1\;5C forward-word
	bind -M insert \e\[1\;5D backward-word
	# Fix home/end keys
	bind -M insert \e\[1~ beginning-of-line
	bind -M insert \e\[4~ end-of-line
	# Fix delete key
	bind -M insert \e\[3~ delete-char
end

function fish_mode_prompt
end

# fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream verbose
set __fish_git_prompt_color_branch magenta

# Status Chars
set __fish_git_prompt_char_prefix '['
set __fish_git_prompt_char_suffix ']'
set __fish_git_prompt_char_upstream_ahead '↑'
set __fish_git_prompt_char_upstream_behind '↓'
set __fish_git_prompt_char_stateseparator '|'
set __fish_git_prompt_char_dirtystate '✚'
set __fish_git_prompt_char_invalidstate '✖'
set __fish_git_prompt_char_stagedstate '●'
set __fish_git_prompt_char_untrackedfiles '…'
set __fish_git_prompt_char_cleanstate '✔'
set __fish_git_prompt_char_upstream_equal ''

function fish_prompt
	set last_status $status
	# Disable directory shortening for prompt_pwd
	set -g fish_prompt_pwd_dir_length 0

	printf "╭─ %s%s%s@%s%s%s:%s%s%s%s\n" (set_color yellow) "$USER" (set_color normal) (set_color magenta) (hostname) (set_color normal) (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (__fish_git_prompt)
	printf "╰─▶ %s%s %s><((\">%s " (set_color normal) (date "+$c2%H$c0:$c2%M$c0") (set_color --bold white) (set_color normal)
end
