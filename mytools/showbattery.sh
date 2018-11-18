#!/bin/bash
# instalar acpi

perc=$(acpi -b | cut -d "," -f 2 | cut -d "%" -f 1)
stat=$(acpi -b | cut -d " " -f 3)

icon=""

if [ $perc -lt 10 ]; then
	icon=""
elif [ $perc -lt 25 ]; then
	icon=""
elif [ $perc -lt 50 ]; then
	icon=""
elif [ $perc -lt 75 ]; then
	icon=""
fi

if [ $stat == "Charging," ]; then
	icon=""
fi

echo "$icon $perc%"
