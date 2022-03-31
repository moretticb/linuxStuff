#!/bin/bash
#
# install gpick
# install dmenu
# install xclip
# install xsel

font="Ubuntu-$($HOME/linuxStuff/mytools/get_ws_fontsize.sh)"



killall -q gpick
hex=$(gpick -so)

if [ "$(echo $hex | cut -c1)" != "#" ]; then
	exit 1
fi

ans=$(echo -e "Yes\nNo" | dmenu -i -p "Send $hex to clipboard?" -nb $hex -fn "$font")

if [ $? = 1 ]; then
	exit 1
fi

if [ $ans = "Yes" ]; then
	echo $hex | xclip -rmlastnl
	xclip -o | xsel -ib
fi

