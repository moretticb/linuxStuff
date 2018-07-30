#!/bin/bash
#
# install dmenu
# install sqlite
# running with firefox only

url=$(sqlite3 /home/duzas/.mozilla/firefox/*.default/places.sqlite "select url,title from moz_places;" | grep http | sed -e "s/|/    /g" | dmenu -p "💩 URL (shift+enter)" -i -l 10 -nb "#EFEFEF" -sb "#333333" -nf "#000000" )

if [ $? = 0 ]; then
	if [ $(echo $url | cut -c1) = "_" ]; then
		url="http://www.google.com/search?q="$(echo $url | cut -c2-)
		xdg-open "$(echo $url)"
	else
		xdg-open $(echo $url | cut -d " " -f 1)
	fi

fi

