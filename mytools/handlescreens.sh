#!/bin/bash
#
# install xrandr
# install dmenu

screens=$(xrandr --current | grep " connected" | cut -d " " -f 1)

targ=$(echo $screens | sed -e "s/ /\n/g" | dmenu -i -p "Target screen")

if [ $? = 1 ]; then
	exit 1
fi

pos=$(echo -e "Same\nLeft\nRight\nAbove\nBelow" | dmenu -i -p "Position")

if [ $? = 1 ]; then
	exit 1
fi

ref=$(echo $screens | sed -e "s/ /\n/g" | grep -v $targ | dmenu -i -p "Reference screen")

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


