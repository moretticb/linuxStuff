#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='\u@\h \W\$ '

alias python='/usr/bin/python2.7'
alias pip='/usr/bin/pip2.7'

export PYTHONSTARTUP=~/.pythonrc
export EDITOR=vim

setfont Lat2-Terminus16.psfu 2>/dev/null

set -o vi

bind 'set show-mode-in-prompt'
bind 'set emacs-mode-string ""' #removes the annoying @
#bind 'set vi-ins-mode-string "\1\e[5 q\2"' #does not work in tty
#bind 'set vi-cmd-mode-string "\1\e[2 q\2"' #does not work in tty
bind 'set vi-ins-mode-string "  "'
bind 'set vi-cmd-mode-string ": "'
bind -m vi-insert "\C-l":clear-screen # so that Ctrl+L clears screen in insertion mode
