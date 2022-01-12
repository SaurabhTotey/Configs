#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTFILE=/tmp/.bash_history
export EDITOR=nvim

alias ls='exa \-la \-\-header \-\-sort=type'
alias rm='trash'
PS1='[\u@\h \W]\$ '

alias confs='setup-dev ~/Development/Configs'
alias update-python-dependencies='pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U'

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
