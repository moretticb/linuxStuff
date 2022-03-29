#!/bin/sh

L="&#57526;" #"\uE0B6"
R="&#57524;" #"\uE0B4"

#total workspaces
wt=$(i3-msg -t get_workspaces | jq '. | length')

# workspace pos
wp=$(i3-msg -t get_workspaces | jq .[].num | grep -n $(i3-msg -t get_workspaces | jq -r 'map(select(.focused))[0].num') | cut -d":" -f 1)

# handling button events before rendering
if [ "$1" = "4" ] && [ "$wp" -gt "1" ]; then # scroll up
	sendto="$(i3-msg -t get_workspaces | jq ".[$(echo "${wp}-2" | bc)].num")"
	i3-msg workspace ${sendto} 1>/dev/null
elif [ "$1" = "5" ] && [ "$wp" -lt "$wt" ]; then # scroll down
	sendto="$(i3-msg -t get_workspaces | jq ".[$(echo "${wp}" | bc)].num")"
	i3-msg workspace ${sendto} 1>/dev/null
elif [ "$1" = "1" ]; then #click
	sendto="$(echo "$3/($2/$wt)" | bc)"
	sendto="$(i3-msg -t get_workspaces | jq ".[${sendto}].num")"
	i3-msg workspace ${sendto} 1>/dev/null
fi



c1="black" #background
c2="white" #foreground
c3="yellow" #urgent workspaces

st="<span color='$c1' bgalpha='40%' fgalpha='40%'>$L</span>"
mid_st="<span color='$c2' bgcolor='$c1' bgalpha='40%' fgalpha='40%'>"
mid_ed="</span>"
ed="<span color='$c1' bgalpha='40%' fgalpha='40%'>$R</span>"

ed2="<span color='$c1' fgalpha='40%' bgcolor='$c1' bgalpha='60%'>$R</span>"
mid_st2="<span color='$c2' bgcolor='$c1' bgalpha='60%'>"
mid_ed2="</span>"
st2="<span color='$c1' fgalpha='40%' bgcolor='$c1' bgalpha='60%'>$L</span>"

st_cnr="<span color='$c1' bgalpha='40%' fgalpha='60%'>$L</span>"
ed_cnr="<span color='$c1' bgalpha='40%' fgalpha='60%'>$R</span>"

#total workspaces
wt=$(i3-msg -t get_workspaces | jq '. | length')

#active workspace position
wp=$(i3-msg -t get_workspaces | jq .[].num | grep -n $(i3-msg -t get_workspaces | jq -r 'map(select(.focused))[0].num') | cut -d":" -f 1)

#active workspace
aw=$(i3-msg -t get_workspaces | jq -r 'map(select(.focused))[0].num')

#workspaces
ws=$(i3-msg -t get_workspaces | jq .[].num | awk '{print}' ORS='')

#before active workspace
ba=$(echo $ws | sed -E "s/([0-9])/ \1 /g" | sed "s/${aw}.*//g" | sed "s/  $/ /g")

#after active workspace
aa=$(echo $ws | sed -E "s/([0-9])/ \1 /g" | sed "s/^.*${aw}//g" | sed "s/^  / /g")


# highlighting urgent workspaces
for w in $(i3-msg -t get_workspaces | jq -r 'map(select(.urgent))[].num'); do
	sed_expr="s/$w/<span color='${c3}'><b>${w}<\/b><\/span>/g"
	ba=$(echo "$ba" | sed "$sed_expr")
	aa=$(echo "$aa" | sed "$sed_expr")
done


if [ "$wp" = "1" ]; then
	# active is at left
	markup="${st_cnr}${mid_st2} ${aw} ${mid_ed2}${st2}${mid_st}${aa}${mid_ed}${ed}"
elif [ "$wp" = "$wt" ]; then
	# active is at right
	markup="${st}${mid_st}${ba}${mid_ed}${ed2}${mid_st2} ${aw} ${mid_ed}${ed_cnr}"
else
	# active is in the middle
	markup="${st}${mid_st}${ba}${mid_ed}${ed2}${mid_st2} ${aw} ${mid_ed2}${st2}${mid_st}${aa}${mid_ed}${ed}"
fi

barnum="$($HOME/linuxStuff/mytools/bar_get_output.sh)"
barwid="$($HOME/linuxStuff/mytools/bar_width_estimate.sh $barnum)"

if [ "$barnum" = "-1" ]; then
	barnum="0"
fi

output=$(cat $HOME/.config/i3/config | grep "^[[:space:]]*output" | sed "$(echo "$barnum+1" | bc)!d" | awk '{print $2}')
outputwid=$(xrandr | grep $output | awk '{print $3}' | cut -d"x" -f 1)
rem_space=$(echo "$outputwid-$barwid" | bc)

fillchars="$($HOME/linuxStuff/mytools/bar_width_estimate.sh $barnum $rem_space)"

fillstr="$(seq $fillchars | awk '{print " "}' ORS='')"



echo -e "${markup}$fillchars"
