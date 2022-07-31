#!/bin/bash
#
# install xrandr
# install dmenu

font="Ubuntu-$($HOME/linuxStuff/mytools/get_ws_fontsize.sh)"


screens=$(xrandr --current | grep " connected" | cut -d " " -f 1)
options=$(xrandr --current | grep " connected" | wc -l)

if test -f "$HOME/scrlayout.sh"; then
	screens=$(echo -e "layout\n$(echo -e "$screens")")
fi

targ=$(echo $screens | sed -e "s/ /\n/g" | dmenu -i -p "Target screen" -fn "$font")

if [ $? = 1 ]; then
	exit 1
fi

if [ "$targ" = "layout" ]; then
	$HOME/scrlayout.sh && nitrogen --set-zoom-fill --random $HOME/wallpapers &
	exit 0
fi

echo "OPTIONS IS $options"
if [ $options = 1 ]; then
	xrandr --current | grep "disconnected" | cut -d" " -f 1 | xargs -I{} xrandr --output {} --off
	exit 0
fi

pos=$(echo -e "Same\nLeft\nRight\nAbove\nBelow" | dmenu -i -p "Position" -fn "$font")

if [ $? = 1 ]; then
	exit 1
fi

ref=$(echo $screens | sed -e "s/ /\n/g" | grep -v "^$targ" | dmenu -i -p "Reference screen" -fn "$font")

if [ $? = 1 ]; then
	exit 1
fi

case $pos in
	Left) pos="--left-of";;
	Right) pos="--right-of";;
	Above) pos="--above";;
	Below) pos="--below";;
	Same) pos="--same-as";;
esac

echo "--output $targ --auto $pos $ref" | xargs xrandr


