#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias python='/usr/bin/python2.7'
alias pip='/usr/bin/pip2.7'

export PYTHONSTARTUP=~/.pythonrc

setfont Lat2-Terminus16.psfu
