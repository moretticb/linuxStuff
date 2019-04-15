#!/bin/sh
#install links
#install dmenu

list="BRL\nUSD\nEURO\nPOUND\nCANADIAN"

#COLOR PALETTE
nb="#E7EBD4"
nf="#695649"
sb="#534741"
sf="#A6CC70"

if [ "$#" = "1" ]; then
	val=$1
	
	from=$(echo -e $list | dmenu -p "$val from" -nb "$nb" -nf "$nf" -sb "$sb" -sf "$sf")
	if [ "$?" != 0 ]; then
		exit 1
	fi

	to=$(echo -e $list | grep -v $from | dmenu -p "to" -nb "$nb" -nf "$nf" -sb "$sb" -sf "$sf")
	if [ "$?" != 0 ]; then
		exit 1
	fi
elif [ "$#" = "2" ]; then
	val=$1
	from=$2
	
	to=$(echo -e $list | grep -v $from | dmenu -p "$val $from to" -nb "$nb" -nf "$nf" -sb "$sb" -sf "$sf")
	if [ "$?" != 0 ]; then
		exit 1
	fi
elif [ "$#" = "3" ]; then
	val=$1
	from=$2
	to=$3
else
	from=$(echo -e $list | dmenu -p "from" -nb "$nb" -nf "$nf" -sb "$sb" -sf "$sf")
	if [ "$?" != 0 ]; then
		exit 1
	fi

	to=$(echo -e $list | grep -v $from | dmenu -p "to" -nb "$nb" -nf "$nf" -sb "$sb" -sf "$sf")
	if [ "$?" != 0 ]; then
		exit 1
	fi

	val=$(echo "" | dmenu -p "$from > $to:" -nb "$nb" -nf "$nf" -sb "$sb" -sf "$sf")
	if [ "$?" != 0 ]; then
		exit 1
	fi

fi

resp="$(links -dump -http.fake-user-agent "MOT-L7/NA.ACR_RB MIB/2.2.1 Profile/MIDP-2.0 Configuration/CLDC-1.1" "    http://www.google.com/search?q=\"$val $from to $to\"&num=1" | grep "=")"

newval=$(echo "$resp" | cut -d"=" -f 2 | sed -E "s/^[[:space:]]+([0-9,]+)[[:space:]]+.*/\1/")

cmd=$(echo -e "SWAP\nCHANGE\nCONTINUE" | dmenu -i -p "$resp" -nb "$nb" -nf "$nf" -sb "$sb" -sf "$sf")
if [ "$?" != 0 ]; then
	$(pwd)/linuxStuff/mytools/currency.sh
elif [ "$cmd" = "SWAP" ]; then
	val="$newval"
	$(pwd)/linuxStuff/mytools/currency.sh $val $to $from
elif [ "$cmd" = "CONTINUE" ]; then
	val="$newval"
	$(pwd)/linuxStuff/mytools/currency.sh $val $to
elif [ "$cmd" = "CHANGE" ]; then
	$(pwd)/linuxStuff/mytools/currency.sh $val $from
else
	$(pwd)/linuxStuff/mytools/currency.sh $cmd $from $to
fi

