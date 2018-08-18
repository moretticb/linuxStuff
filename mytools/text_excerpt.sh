echo "Pesquisa de trecho: $1"

wget -U "MOT-L7/NA.ACR_RB MIB/2.2.1 Profile/MIDP-2.0 Configuration/CLDC-1.1" "http://www.google.com/search?q=\"$1\"&num=30" --no-http-keep-alive  -O /tmp/text_excerpt.html

cat /tmp/text_excerpt.html | sed -E "s/(<div [^>]* class=\"web_result\")/\n\n\1/g" | iconv -f iso-8859-1 -t utf8 | grep web_result > /tmp/text_excerpt2.html

zenity --text-info --html --filename=/tmp/text_excerpt2.html --width 700 --height 500

rm /tmp/text_excerpt.html
rm /tmp/text_excerpt2.html

#line=$(links -dump -http.fake-user-agent "MOT-L7/NA.ACR_RB MIB/2.2.1 Profile/MIDP-2.0 Configuration/CLDC-1.1" "http://www.google.com/search?q=\"$1\"&num=20" | sed -E "s/^([^\/]*)\//\n\1/g" | sed "s/$1/<b>$1<\/b>/gI" | dmenu -l 15 -p "(E) $(echo $1 | cut -c-13)... (Ctrl+Enter)" -nb "#EFEFEF" -nf "#454545" -sb "#0288D1" -sf "#222222")


#if [ $? = 1 ]; then
	exit 1;
#fi

#$(pwd)/linuxStuff/mytools/text.sh "-" "$line" "$2"
#~/linuxStuff/mytools/text.sh "-" "$line" "$2"
