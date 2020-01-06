#!/bin/sh

program=$(dmenu_path | dmenu)

if [ $? = 1 ]; then
	exit 1
fi

scale=$(echo -e "0.5\n1\n1.5\n2" | dmenu -p "scale")

if [ $? = 1 ]; then
	exit 1
fi

env GDK_SCALE=$scale GDK_DPI_SCALE=$scale CLUTTER_SCALE=$scale $program

