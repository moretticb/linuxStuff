#!/bin/bash
#
# instalar bc
# instalar dmenu

xpr="0"
ans="0"
lastxpr="0"

while :; do
	xpr=$(echo | dmenu -p "ans = $ans" -sf "#FFFFFF" -sb "#000000" -nb "#FFFFFF" -nf "#000000" -fn "Ubuntu-25")

	if [ $? = 1 ]; then
		exit 1;
	fi

	if [ $xpr = "=" ]; then
		xpr=$lastxpr
	else
		lastxpr=$xpr
	fi

	xpr=$(echo $xpr | sed $(echo "s/ans/$ans/g"))

	echo "expressao: " $xpr

	ans=$(echo $xpr | bc -l)

done
