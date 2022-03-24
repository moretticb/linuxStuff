#!/bin/bash

config_file="$HOME/linuxStuff/.config/i3blocks/config"

cp "${config_file}" "${config_file}_bkp"

bar_wids="$($HOME/linuxStuff/mytools/bar_width_estimate.sh)"
ws_num_size=$(cat $config_file | grep "^min_width= " | cut -d" " -f 2)
gap_size="1920-5-5-5-${ws_num_size}-$(echo $bar_wids | cut -d" " -f 1)"

echo $gap_size
gap_size=$(echo "$gap_size" | bc)
echo "=$gap_size"

# inplace replacement of the line
sed -Ei "s/^(separator_block_width= )[0-9]+/\1$gap_size/g" ${config_file}

