#!/bin/sh

dnum="$(bluetoothctl devices | cut -d" " -f 3- | grep -n "" | dmenu | cut -d":" -f 1)"

if [ $? != 0 ]; then
	exit 1;
fi

macaddr="$(bluetoothctl devices | sed -n "$dnum"p | cut -d" " -f 2)"

bluetoothctl << EOF
power on
agent on
connect $macaddr
EOF

