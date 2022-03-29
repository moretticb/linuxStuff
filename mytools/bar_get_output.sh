#!/bin/sh

# this MUST be called within a script that has i3bar as a parent process somewhere along the chain

ppid=$(ps -eo ppid | grep $$)
i="0"
while true; do
	if [ "$i" -gt "10" ]; then
		echo -1
		exit 0
	fi

	parent=$(ps -eo pid,ppid,cmd | grep "^[ ]*$ppid" | head -1)

	if [ "$(echo $parent | grep "bar-" | wc -l)" -ne "0" ]; then
		break
	fi

	ppid=$(echo $parent | cut -d" " -f 2)

	i="$(echo "$i+1" | bc)"
done
bar=$(echo $parent | cut -d"-' -f 6)

echo $bar
