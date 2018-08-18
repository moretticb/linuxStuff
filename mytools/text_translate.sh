echo "Traduzir: $1"
lang=$(echo -e "en\npt\nit\npt-en\nen-pt\npt-it\nit-pt\nit-en\nen-it" | dmenu -p "(T) To-From" -nb "#EFEFEF" -nf "#454545" -sb "#0288D1" -sf "#222222")

if [ $? = 1 ]; then
	exit 1;
fi

from="$(echo $lang | cut -d"-" -f 1)"
to="$(echo $lang | cut -d"-" -f 2)"

if [ "$from" = "$to" ]; then
	from="auto"
fi

transl="$(wget -U "Mozilla/5.0" -qO - "http://translate.googleapis.com/translate_a/single?client=gtx&sl=$(echo $from)&tl=$(echo $to)&dt=t&q=$(echo \"$1\" | sed "s/[\"'<>]//g")" | sed "s/,,,0]],,.*//g" | awk -F'"' '{print $2, $6}' | rev | cut -b 3- | rev)"

#$(pwd)/linuxStuff/mytools/text.sh "-" "$transl" "$2"
~/linuxStuff/mytools/text.sh "-" "$transl" "$2"
