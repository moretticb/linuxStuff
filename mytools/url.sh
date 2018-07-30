#!/bin/bash
#
# install dmenu
# install sqlite
# install xdg-utils
# compatible with firefox only

#more about firefox sqlite tables at https://developer.mozilla.org/en-US/docs/Mozilla/Tech/Places/Database
url=$(sqlite3 /home/duzas/.mozilla/firefox/*.default/places.sqlite "select moz_places.url,moz_places.title,moz_historyvisits.visit_date from moz_places,moz_historyvisits where moz_historyvisits.place_id=moz_places.id order by 3 desc;" | grep http | cut -d "|" -f 1-2 | sed -e "s/|/    /g" | dmenu -p "💩 URL (shift+enter)" -i -l 10 -nb "#EFEFEF" -sb "#333333" -nf "#000000" )

if [ $? = 0 ]; then
	if [ $(echo $url | cut -c1) = "_" ]; then
		url="http://www.google.com/search?q="$(echo $url | cut -c2-)
		xdg-open "$(echo $url)"
	else
		xdg-open $(echo $url | cut -d " " -f 1)
	fi

fi

