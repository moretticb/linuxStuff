#!/bin/sh

output=$(i3-msg -t get_workspaces | jq "map(select(.focused))[0].output" | sed "s/\"//g")
line=$(echo "$(cat $HOME/.config/i3/config | grep -n "^[[:space:]]*output $output" | cut -d":" -f 1)+1" | bc)
echo $(cat $HOME/.config/i3/config | sed ${line}'!d' | rev | cut -d" " -f 1 | rev)

