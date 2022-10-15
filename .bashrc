#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Reboot directly to Windows
# Inspired by http://askubuntu.com/questions/18170/how-to-reboot-into-windows-from-ubuntu
reboot_to_windows ()
{
    windows_title=$(grep -i windows /boot/grub/grub.cfg | cut -d "'" -f 2)
    sudo grub-reboot "$windows_title" && sudo reboot
}
alias reboot-to-windows='reboot_to_windows'
# For linux -> windows: use reboot_to_windows
# For windows -> linux: check linuxStuff/mytools/reboot_to.ps1 file

export BROWSER="firefox"


alias ls='ls --color=auto'
PS1='\u@\h \W\$ '

#alias python='/usr/bin/python2.7'
#alias pip='/usr/bin/pip2.7'

export PYTHONSTARTUP=~/.pythonrc
export EDITOR=vim

set -o vi

bind 'set show-mode-in-prompt'
bind 'set emacs-mode-string ""' #removes the annoying @
#bind 'set vi-ins-mode-string "\1\e[5 q\2"' #does not work in tty
#bind 'set vi-cmd-mode-string "\1\e[2 q\2"' #does not work in tty
bind 'set vi-ins-mode-string "  "'
bind 'set vi-cmd-mode-string ": "'
bind -m vi-insert "\C-l":clear-screen # so that Ctrl+L clears screen in insertion mode



#function _update_ps1() {
#	PS1=$(powerline-shell $?)
#}
#
#if [[ STERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
#	PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
#fi

neofetch

