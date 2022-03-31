#!/bin/sh

icon="&#61672;"
addr=$(ip -4 address show | tr '\n' '#' | sed -E "s/#([0-9]: )/\n\1/g" | sed "s/#//g" | grep -v "127.0.0.1" | awk '{print $15}' | head -1)
iwgetid 1>/dev/null
if [ "$?" = "0" ]; then #if wifi
	icon="&#61931;"
	dev="$(iwgetid | cut -d' ' -f 1)"
	addr=$(ip -4 address show | tr '\n' '#' | sed -E "s/#([0-9]: )/\n\1/g" | sed "s/#//g" | grep "$dev" | awk '{print $15}')
	addr="$(iwgetid --raw) $addr"
fi

$HOME/linuxStuff/mytools/barsections.sh black yellow "$icon" "$addr"

