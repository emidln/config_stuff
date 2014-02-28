# bja@localhost:~ $ 
color_prompt="yes"
if [ "$color_prompt" = yes ]; then
	PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\] \$ '
else
	PS1='\u@\h:\W \$ '
fi
export PS1
#export PS1='\u@\h:\W \$ '

# vi-style navigation in bash
set -o vi

export HISTFILE="~/.bash_history"
export HISTFILESIZE=20000

# setup bash options
shopt -s histappend
shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s expand_aliases
shopt -s extglob
shopt -s hostcomplete

# prefew homebrew things
export PATH="/usr/local/bin:$PATH"

# make tmux use all the colors
alias tmux="tmux -2"

# osx's ls uses -G for colored output
alias ls="ls -G"
alias la="ls -a"
alias ll="ls -lah"

# setup python's virtualenv functions
. /usr/local/bin/virtualenvwrapper.sh

# setup bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi
