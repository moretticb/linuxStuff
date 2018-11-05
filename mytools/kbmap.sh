#!/bin/sh

map=$(echo -e "us|pc105\nbr|abnt2" | dmenu -p "Keyboard map")

if [ $? != 0 ]; then
	exit 1
fi

layout=$(echo $map | cut -d'|' -f 1)
model=$(echo $map | cut -d'|' -f 2)

setxkbmap -model $model -layout $layout

