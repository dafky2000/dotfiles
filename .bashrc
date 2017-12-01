#!/bin/bash
# ~/.bashrc
# RESET="\[$(tput sgr0)\]"
# GIT_PROMPT_ONLY_IN_REPO=0
# GIT_PROMPT_END="$White \n$(date +%H:%M) $RESET${USER}@$HOSTNAME \$ "
# source ~/.bash-git-prompt/gitprompt.sh

HISTSIZE=100000
HISTFILESIZE=100000
HISTCONTROL=erasedups

# # append instead of overwriting history, and do it in realtime
# shopt -s histappend
# export PROMPT_COMMAND='history -a'
# # add date / time to history entries
# export HISTTIMEFORMAT='%b %d %H:%M '

export EDITOR=vim
export VISUAL=vim
export GIT_EDITOR=vim
export SVN_EDITOR=vim
# export CC="/usr/bin/clang -ggdb3 -O0 -std=c11 -Werror -Wshadow"
# export CXX="/usr/bin/clang++ -ggdb3 -O0 -std=c++11 -Werror -Wshadow"

alias sudo="sudo " # Makes the aliases carry into the sudo environment
alias wgrep='grep -rn --color=always --exclude-dir=.svn --exclude-dir=.git'

# setenv port to bash so we can set env variables as a parameter
function setenv() { export "$1=$2"; }
