#!/bin/sh
#
# install zenity
# install xclip
# install xsel
# give permission to execute with chmod +x

if [ "`xclip -o`" != "`xsel -b`" ]; then
	echo `xsel -b` | xclip -rmlastnl
fi


text=$(zenity --entry --entry-text=`xclip -o` --text="wc: `xclip -o | wc`" --title="Send to clipboard:")

if [ "$?" = "1" ]; then

	xclip -o
	err=$?
	if [ $err == 1 ]; then
		echo "XSEL CONTEM: " `xsel -b`
		#echo `xsel -b` | xclip -rmlastnl
		exit 0
	fi

	if [ "`xclip -o`" != "`xsel -b`" ]; then
		echo `xsel -b` | xclip -rmlastnl
	fi


	exit 0
fi


echo $text | xclip -rmlastnl
echo `xclip -o` | xclip -rmlastnl -selection clipboard -i
echo "agora: `xclip -o`"


exit 0

