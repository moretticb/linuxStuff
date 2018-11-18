sleep 0.1

status="$(playerctl status spotify)"

icon=$([ $status == "Playing" ] && echo "" || echo "")

$HOME/linuxStuff/mytools/barmsg.sh "$icon $(playerctl -p spotify metadata xesam:artist) - $(playerctl -p spotify metadata xesam:title)"
