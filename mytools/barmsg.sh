file="/tmp/barmsg.txt"
# DO NOT CHANGE FIRST LINE! IT IS USED ELSEWHERE WITH EVAL

echo "$1" > $file
pkill -RTMIN+12 i3blocks
