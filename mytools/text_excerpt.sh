#!/bin/sh

font="Ubuntu-$($HOME/linuxStuff/mytools/get_ws_fontsize.sh)"

echo "Pesquisa de trecho: $1"

wget -U "MOT-L7/NA.ACR_RB MIB/2.2.1 Profile/MIDP-2.0 Configuration/CLDC-1.1" "http://www.google.com/search?q=\"$1\"&num=30" --no-http-keep-alive  -O /tmp/text_excerpt.html

cat /tmp/text_excerpt.html | sed -E "s/(<div [^>]* class=\"web_result\")/\n\n\1/g" | iconv -f iso-8859-1 -t utf8 | grep web_result | sed -E "s/=\"\//=\"http:\/\/www.google.com\//g" > /tmp/text_excerpt2.html


pandoc /tmp/text_excerpt.html -o /tmp/text_excerpt.txt
line=$(cat /tmp/text_excerpt.txt | grep -E "^[|][^|]*[|]$" | grep -v "<[/]*div>" | sed "s/|//g" | dmenu -l 25 -p "$(echo $1 | cut -b-15)..." -nb "#EFEFEF" -nf "#454545" -sb "#0288D1" -sf "#222222" -fn "$font")

rm /tmp/text_excerpt.html
rm /tmp/text_excerpt.txt


$HOME/linuxStuff/mytools/text.sh "-" "$line" "$2"
