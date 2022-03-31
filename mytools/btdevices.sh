#!/bin/sh

font="Ubuntu-$($HOME/linuxStuff/mytools/get_ws_fontsize.sh)"

action="connect"
alt="disconnect"
if [ "$1" == "disconnect" ]; then
	action="disconnect"
	alt="connect"
fi



dnum="$(bluetoothctl devices | cut -d" " -f 3- | grep -n "" | sed -E "s/1/0:$alt\n1/g" | dmenu -p "$action" -fn "$font" | cut -d":" -f 1)"

if [ $? != 0 ]; then
	exit 1;
fi

if [ $dnum == 0 ]; then
	$0 $alt
	exit 1;
fi

macaddr="$(bluetoothctl devices | sed -n "$dnum"p | cut -d" " -f 2)"

bluetoothctl << EOF
power on
agent on
trust $macaddr
$action $macaddr
EOF

