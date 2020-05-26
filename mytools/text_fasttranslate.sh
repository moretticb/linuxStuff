txt="$(xsel)"
echo "Traduzir: $txt"

from="$(wget -U "Mozilla/5.0" -qO - "http://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=pt&dt=at&q=$txt" | head -1 | sed "s/,/\n/g" | grep -E '"[a-z]{2}"' | sed 's/"//g')"
echo "from is $from"
to="pt"
if [ $from = "pt" ]; then
	to="en";
fi

line=$(wget -U "Mozilla/5.0" -qO - "http://translate.googleapis.com/translate_a/single?client=gtx&sl=$from&tl=$to&dt=at&q=$txt" | sed -E "s/\[\"([^\"]+)\"[a-z,0-9]+\]/\n\1\n/g" | grep -v "\[" | grep -v "^.$" | dmenu -l 5 -p "(T $from-$to) $(echo $1 | cut -b-15)..." -nb "#EFEFEF" -nf "#454545" -sb "#0288D1" -sf "#222222")

if [ "$?" = 1 ]; then
	exit 1;
fi

#$(pwd)/linuxStuff/mytools/text.sh "-" "$transl" "$2"
~/linuxStuff/mytools/text.sh "-" "$line" "$2"
