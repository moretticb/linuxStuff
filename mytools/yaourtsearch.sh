#!/bin/bash
#
# install dmenu

font="Ubuntu-$($HOME/linuxStuff/mytools/get_ws_fontsize.sh)"

search=$(echo | dmenu -p "Yaourt search:" -nf "#FFA500" -nb "#000000" -sf "#000000" -sb "#FFA500" -fn "$font")

if [ $? = 0 -a "$search" != "" ]; then
	line=$(yaourt -Ss $search | awk '{key=$0; getline; print key $0;}' | grep aur | dmenu -l 10 -nf "#FFA500" -nb "#000000" -sf "#000000" -sb "#FFA500" -fn "Ubuntu-9")
	if [ $? = 0 ]; then
		termite --title="Installing $line" --exec="bash -c 'yaourt -S $(echo $line | cut -d " " -f 1) --noconfirm; read -p \"Yaourt installation finished\"'"
	fi
fi
