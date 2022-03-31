#!/bin/sh

font="Ubuntu-$($HOME/linuxStuff/mytools/get_ws_fontsize.sh)"

cards="$(pacmd list-cards | head -1 | cut -d' ' -f 1)"
card="$(pacmd list-cards | grep alsa.card_name | cut -d'"' -f 2 | grep -n . | dmenu -i -p "Audio card" -fn "$font" | cut -d':' -f 1)"

cardIndex=$(echo "$card -1" | bc)

if [ $cardIndex -lt 0 ]; then
	exit 1
fi

profilesFirst=$(( $(pacmd list-cards | grep -n profiles | head -`echo $card` | tail -1 | cut -d':' -f 1)+1 ))
profilesLast=$(( $(pacmd list-cards | grep -n active | head -`echo $card` | tail -1 | cut -d':' -f 1)-1 ))

profile=$(pacmd list-cards | sed -n "$profilesFirst, $profilesLast p" | grep -v "available: no" | cut -d' ' -f 1 | sed "s/:$//g" | sed -E "s/^[[:space:]]+(.*)/\1/g" | dmenu -i -p "Card $card | Profile")

if [ $? != 0 ]; then
	exit 1
fi

for i in `seq 0 $(( $cards-1 ))`; do
	pacmd set-card-profile $i off
done

pacmd set-card-profile $cardIndex $profile
