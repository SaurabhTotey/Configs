#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTFILE=/tmp/.bash_history
export EDITOR=nvim

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias confs='setup-dev ~/Development/Configs'
