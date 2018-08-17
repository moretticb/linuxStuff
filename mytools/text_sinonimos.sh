#usar zenith para digitar palavra e buscar sinonimo
#	abrir zenith com o que estiver no clipboard

echo "Pesquisa em sinonimos: $1"
line=$(links -dump https://www.sinonimos.com.br/$1/ | sed -E "s/^   ([^0-9A-Z][^,]*)$//g" | sed -E "s/^   [A-Z].*[^:.]$//g" | sed -E "s/^   ([A-Z])/\1/g" | grep -v ^$ | dmenu -p "(S) $1" -l 10 -nb "#EFEFEF" -nf "#454545" -sb "#0288D1" -sf "#222222")

if [ $? = 1 ]; then
	exit 1;
fi

$(pwd)/linuxStuff/mytools/text.sh "-" "$line" "$2"

