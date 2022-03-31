#!/bin/sh

font="Ubuntu-$($HOME/linuxStuff/mytools/get_ws_fontsize.sh)"

echo "Speak: $1"
lang=$(echo -e "en\npt\nit\nes\nfr\nde" | dmenu -p "(S) Speak" -nb "#EFEFEF" -nf "#454545" -sb "#0288D1" -sf "#222222" -fn "$font")

if [ $? = 1 ]; then
	exit 1;
fi

wget -q -U Mozilla -O /tmp/text_tts.mp3 "https://translate.google.com.vn/translate_tts?ie=UTF-8&q=$1&tl=$lang&client=tw-ob" && cvlc --play-and-exit /tmp/text_tts.mp3 && rm /tmp/text_tts.mp3 && kill $(ps aux | grep Kill | grep -v grep | head -1 | sed -E "s/[[:space:]]+/ /g" | cut -d" " -f 2) &


willkill=$(echo -e "Yes\nNo" | dmenu -p "Kill audio?" -nb "#EFEFEF" -nf "#454545" -sb "#0288D1" -sf "#222222" -fn "$font")

if [ "$willkill" = "Yes" ]; then
	kill $(ps aux | grep tts | grep -v grep | head -1 | sed -E "s/[[:space:]]+/ /g" | cut -d" " -f 2)
fi

~/linuxStuff/mytools/text.sh "-" "$1" "$2"
