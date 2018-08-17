if [ "$1" = "-" ]; then
	input=$(echo "$2" | sed -E "s/[[:space:][:punct:]]+/\n/g" | dmenu -i -nb "#EFEFEF" -nf "#454545" -sb "#0288D1" -sf "#222222")
	lastAction=$3
elif [ "$1" != "" ]; then
	input=$1
else
	input=$(echo "" | dmenu -i -p "Text" -sb "#0288D1" -nf "#0288D1")
fi

input=$(echo "$input" | iconv -f utf8 -t ascii//TRANSLIT)

action=$(echo -e "$lastAction\nDictionary\nSynonym\nExcerpt\nTranslation" | awk '!x[$0]++' | dmenu -i -sb "#0288D1" -nf "#0288D1")

if [ $action == "Dictionary" ]; then
	$(pwd)/linuxStuff/mytools/text_dicio.sh "$input" "$action"
elif [ $action == "Synonym" ]; then
	$(pwd)/linuxStuff/mytools/text_sinonimos.sh "$input" "$action"
elif [ $action == "Excerpt" ]; then
	echo "not implemented"
elif [ $action == "Translation" ]; then
	echo "not implemented"
fi



