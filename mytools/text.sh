# instalar links

font="Ubuntu-$($HOME/linuxStuff/mytools/get_ws_fontsize.sh)"

if [ "$1" = "-" ]; then
	lastAction=$3
	input=$(echo -e "0line0\n$2" | sed -E "s/[[:space:][:punct:]]+/\n/g" | dmenu -i -nb "#EFEFEF" -nf "#454545" -sb "#0288D1" -sf "#222222" -fn "$font")
	if [ "$input" = "0line0" ]; then
		input=$(echo "$2" |  sed -E "s/[ ]+/ /g" | zenity --text-info --editable --title="Ctrl+Tab to change focus")
	fi
elif [ "$1" != "" ]; then
	input=$1
else
	input=$(echo "" | dmenu -i -p "Text" -sb "#0288D1" -nf "#0288D1" -fn "$font")
fi

input=$(echo "$input" | iconv -f utf8 -t ascii//TRANSLIT)

action=$(echo -e "$lastAction\nDictionary\nSynonym\nExcerpt\nTranslation\nSpeak" | awk '!x[$0]++' | grep -v ^$ | dmenu -i -sb "#0288D1" -nf "#0288D1" -fn "$font")

if [ "$action" == "Dictionary" ]; then
	$HOME/linuxStuff/mytools/text_dicio.sh "$input" "$action"
elif [ "$action" == "Synonym" ]; then
	$HOME/linuxStuff/mytools/text_sinonimos.sh "$input" "$action"
elif [ "$action" == "Excerpt" ]; then
	$HOME/linuxStuff/mytools/text_excerpt.sh "$input" "$action"
elif [ "$action" == "Translation" ]; then
	$HOME/linuxStuff/mytools/text_translate.sh "$input" "$action"
elif [ "$action" == "Speak" ]; then
	$HOME/linuxStuff/mytools/text_speak.sh "$input" "$action"
fi



