#!/bin/bash
#
# install dmenu
# install sqlite
# install xdg-utils
# compatible with firefox only

#more about firefox sqlite tables at https://developer.mozilla.org/en-US/docs/Mozilla/Tech/Places/Database
place_id=$(sqlite3 /home/duzas/.mozilla/firefox/*.default/places.sqlite "select moz_places.id,substr(moz_places.url,0,55),moz_places.title,moz_historyvisits.visit_date from moz_places,moz_historyvisits where moz_historyvisits.place_id=moz_places.id order by 4 desc;" | grep http | cut -d "|" -f 1-3 | sed -e "s/|/    /g" | dmenu -p "💩 URL (shift+enter)" -i -l 10 -nb "#EFEFEF" -sb "#333333" -nf "#000000" -fn "Ubuntu-9")

if [ $? = 0 ]; then
	if [ $(echo $place_id | cut -c1) = "_" ]; then
		url="http://www.google.com/search?q="$(echo $place_id | cut -c2-)
		xdg-open "$(echo $url)"
	else
		place_id=$(echo $place_id | cut -d " " -f 1)
		url=$(sqlite3 /home/duzas/.mozilla/firefox/*.default/places.sqlite "select url from moz_places where id=$place_id")
		xdg-open $(echo $url)
	fi

fi

