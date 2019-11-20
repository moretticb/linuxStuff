#!/bin/sh

location="cambridge"

temp_c=$(links -dump -http.fake-user-agent "MOT-L7/NA.ACR_RB MIB/2.2.1 Profile/MIDP-2.0 Configuration/CLDC-1.1" "http://www.google.com/search?q=weather%20$location%20celsius&num=1" | grep "°")

temp_f=$(links -dump -http.fake-user-agent "MOT-L7/NA.ACR_RB MIB/2.2.1 Profile/MIDP-2.0 Configuration/CLDC-1.1" "http://www.google.com/search?q=weather%20$location%20fahrenheit&num=1" | grep "°")

$HOME/linuxStuff/mytools/barmsg.sh $(echo "$temp_c | $temp_f" | sed "s/[[:space:]]*//g")
