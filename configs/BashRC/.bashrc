#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR=nvim

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Commands to setup a development environment within a terminal in the current directory TODO: make this a script in /usr/local/bin
alias setup-dev="tmux new-session -d -x '$(tput cols)' -y '$(tput lines)' -n editor 'nvim .';tmux split-window -dv -p 10;tmux new-window -n bash -d;tmux attach-session"
