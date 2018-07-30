#!/bin/sh
#
# install dmenu
# install scrot
# give permission to execute with chmod +x
# create folder .screenshots at /home/duzas

#file=$(zenity --entry --title="Screenshot taken! $1" --text="File name:")
file=$(echo "" | dmenu -p "Screenshot $1 filename (empty for timestamp):" -nb "#FFFFFF" -nf "#000000" -sb "#CCCCCC" -sf "#666666" -fn "Ubuntu-9")

if [ "$?" = "1" ]; then
	echo "Canceled. Exiting..."
	exit 1
elif [ "$file" = "" ]; then
	file="%Y-%m-%d_%H-%M-%S"
fi

if [ "$1" = "Crop" ]; then
	echo saving $file"_Crop".png
	scrot -sz -m /home/duzas/.screenshots/$file"_Crop".png
else
	echo saving $file"_Full".png
	scrot -m /home/duzas/.screenshots/$file"_Full".png
fi




