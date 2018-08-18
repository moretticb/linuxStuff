echo "Pesquisa em dicionario: $1"
line=$(links -dump https://www.dicio.com.br/$1/ | tail --lines=+11 | dmenu -l 10 -p "(D) $1" -nb "#EFEFEF" -nf "#454545" -sb "#0288D1" -sf "#222222")

if [ $? = 1 ]; then
	exit 1;
fi

#$(pwd)/linuxStuff/mytools/text.sh "-" "$line" "$2"
~/linuxStuff/mytools/text.sh "-" "$line" "$2"
