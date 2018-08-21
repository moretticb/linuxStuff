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

line=$(wget -U "Mozilla/5.0" -qO - "http://translate.googleapis.com/translate_a/single?client=gtx&sl=$from&tl=$to&dt=at&q=$1" | sed -E "s/\[\"([^\"]+)\"[a-z,0-9]+\]/\n\1\n/g" | grep -v "\[" | grep -v "^.$" | dmenu -l 5 -p "(T) $1" -nb "#EFEFEF" -nf "#454545" -sb "#0288D1" -sf "#222222")

if [ "$?" = 1 ]; then
	exit 1;
fi

#$(pwd)/linuxStuff/mytools/text.sh "-" "$transl" "$2"
~/linuxStuff/mytools/text.sh "-" "$line" "$2"
