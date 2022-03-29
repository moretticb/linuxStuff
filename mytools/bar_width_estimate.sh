#!/bin/sh

#i3blocks 1>/tmp/i3blocksrender.txt 2>/dev/null & sleep 0.5 && kill $!

# fetching bar font size in i3 config file
font=$(cat $HOME/.config/i3/config | grep Powerline | rev | cut -d" " -f 1 | rev)

# counting rendered chars (converting non-ascii to ascii) considering all blocks but workspace buttons
chars=$(cat /tmp/i3blocksrender.txt | jq .[-1][].full_text 2>/dev/null | tail +2 | sed "s/<[^>]*>//g" | sed "s/&#[0-9]*;/#/g" | awk '{print}' ORS='' | sed "s/\"//g" | iconv -f UTF8 -t US-ASCII//TRANSLIT | wc -c)

# sum of separator widths between blocks (except the separator from workspace buttons)
seps=$(echo "$(cat $HOME/.config/i3blocks/config | grep ^separator_block_width | tail -n +3 | cut -d"=" -f 2 | awk '{print}' ORS='+') 0" | bc)

# Kerning function
# from current monospace font (and using mouse coordinates to measure width of 2 consecutive rendered characters), the following font_size-char_width relation was obtained:
#
# x	y
# font	(width of chars)/2
# 11	8.5
# 18	13
#
# assuming there is a linear relationship, the following linear function was obtained
# y-y0 = m(x-x0) --> 13-8.5 = m(18-11) --> 4.5 = 7m --> m=4.5/7=0.642857
m="0.642857"
# y = mx + b --> 13 = (0.642857)18 + b --> b=13-11.571426=1.428754
b="1.428754"
# That function tells us that ascii chars are on average y pixels wide. Given that non-ascii characters are bigger than the average ascii character when rendered, a compensation term was added to tweak the b term of the line equation
comp="1"
#


barnum="$1"
if [ "$#" = "0" ]; then
        barnum=0
fi

font=$(echo $font | cut -d" " -f $(echo "$barnum+1" | bc))


# Given the remaing space to fill the bar, calculate how many chars to fill that space
if [ "$#" = "2" ]; then
	# making the equation from the end equal the remaining space
	# isolate chars, so one can find the respective amount of chars to fill such space
	#($m * $font + $b + $comp) * $chars + $seps ==  $2
	#($m * $font + $b + $comp) * $chars         ==  $2 - $seps
	#                            $chars         == ($2 - $seps) / ($m * $font + $b + $comp)
	echo "($2 - $seps)/($m * $font + $b + $comp) / 1" | bc


        exit 0
fi




# The kerning (per character) is multiplied by the total number of rendered characters (plus separator gaps) to estimate the total width

echo "(($m * $font + $b + $comp) * $chars + $seps) / 1" | bc

