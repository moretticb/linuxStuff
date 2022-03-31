#!/bin/sh

font="Ubuntu-$($HOME/linuxStuff/mytools/get_ws_fontsize.sh)"

echo "Pesquisa em dicionario: $1"
line=$(links -dump https://www.dicio.com.br/$(echo "$1" | awk '{print tolower($0)}')/ | tail --lines=+11 | dmenu -l 10 -p "(D) $1" -nb "#EFEFEF" -nf "#454545" -sb "#0288D1" -sf "#222222" -fn "$font")

if [ $? = 1 ]; then
	exit 1;
fi

#$(pwd)/linuxStuff/mytools/text.sh "-" "$line" "$2"
$HOME/linuxStuff/mytools/text.sh "-" "$line" "$2"
