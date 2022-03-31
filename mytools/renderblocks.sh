#!/bin/bash

i3blocks 1>/tmp/i3blocksrender.txt 2>/dev/null & sleep 1 && kill $!

cfgdir="$HOME/.config/i3blocks"

rm ${cfgdir}/config_*

i="0"
for output in $(cat ${cfgdir}/../i3/config | grep "^[[:space:]]*output" | awk '{print $2}'); do
	barwid="$($HOME/linuxStuff/mytools/bar_width_estimate.sh $i)"
	outputwid=$(xrandr | grep "${output} [^d]" | awk '{print $3}' | cut -d"x" -f 1)

	if [ -n "$outputwid" ]; then
		rem_space=$(echo "$outputwid - $barwid" | bc)
		sed -E "s/(^min_width= )[0-9]+/\1$rem_space/g" "${cfgdir}/config" > "$cfgdir/config_$output"

		echo "output $output has wid $barwid, with $rem_space of remaining space"
	fi

	i="$(echo "$i+1" | bc)"
done


