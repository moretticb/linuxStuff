#!/bin/bash
#
# install dmenu


search=$(echo | dmenu -p "Pacman search:" -nf "#FFFF00" -nb "#000000" -sf "#000000" -sb "#FFFF00")

if [ $? = 0 -a "$search" != "" ]; then
	line=$(pacman -Ss $search | awk '{key=$0; getline; print key $0;}' | dmenu -l 10 -nf "#FFFF00" -nb "#000000" -sf "#000000" -sb "#FFFF00" -fn "Ubuntu-9")
	if [ $? = 0 ]; then
		termite --title="Installing $line" --exec="sudo pacman -S $(echo $line | cut -d " " -f 1)" --hold
	fi
fi
