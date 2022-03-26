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

#line=$(wget -U "Mozilla/5.0" -qO - "http://translate.googleapis.com/translate_a/single?client=gtx&sl=$from&tl=$to&dt=at&q=$1" | jq .[5][0][2][0][0] | dmenu -l 5 -p "(T $from-$to) $(echo $1 | cut -b-15)..." -nb "#EFEFEF" -nf "#454545" -sb "#0288D1" -sf "#222222")

#line=$(wget -U "Mozilla/5.0" -qO - "http://translate.googleapis.com/translate_a/single?client=gtx&sl=$from&tl=$to&dt=at&q=$1" | sed -E "s/\[\"([^\"]+)\"[a-z,0-9]+\]/\n\1\n/g" | grep -v "\[" | grep -v "^.$" | dmenu -l 5 -p "(T $from-$to) $(echo $1 | cut -b-15)..." -nb "#EFEFEF" -nf "#454545" -sb "#0288D1" -sf "#222222")

user_agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0"
header="Accept: text/json"
#api_url="http://translate.googleapis.com/translate_a/single?client=gtx&sl=$from&tl=$to&dt=at&q=$1"
api_url="http://translate.googleapis.com/translate_a/single"
line=$(\
	curl\
	--header "${header}"\
	--user-agent "${user_agent}"\
	--data-urlencode "client=gtx"\
	--data-urlencode "sl=$from"\
	--data-urlencode "tl=$to"\
	--data-urlencode "dt=at"\
	--data-urlencode "q=$1"\
	 -sL "${api_url}" | jq .[5][0][2][0][0] | dmenu -l 5 -p "(T $from-$to) $(echo $1 | cut -b-15)..." -nb "#EFEFEF" -nf "#454545" -sb "#0288D1" -sf "#222222")


if [ "$?" = 1 ]; then
	exit 1;
fi

#$(pwd)/linuxStuff/mytools/text.sh "-" "$transl" "$2"
~/linuxStuff/mytools/text.sh "-" "$line" "$2"
