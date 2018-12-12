#!/bin/sh
clear

parentPID=$(ps -eo ppid,cmd | grep $0 | grep -v grep | cut -d "/" -f 1 | head -1)
fileFormat=$(ps -eo pid,cmd | grep "$parentPID" | grep -v grep | cut -d "." -f 2)

opt="goo"
if [ $(echo $fileFormat | wc -w) -gt 1 ]; then
	echo "> $1"
	echo "No file format found. Choose the language:"
	echo -e "\nLANGUAGES:"
	echo "  goo - Google search"
	echo "   sh - Shell"
	echo "    c - C"
	echo "    r - R"

	echo -e "\nLast: $(cat /tmp/vim_lastdoc 2>/dev/null)"

	read -p "> " opt
else
	echo "The file format is $fileFormat."
	opt=$fileFormat
fi

if [ "$opt" == "" ]; then
	echo "using last option: $(cat /tmp/vim_lastdoc)"
	opt=$(cat /tmp/vim_lastdoc)
fi

echo $opt > /tmp/vim_lastdoc

case $opt in
	"goo") xdg-open "http://www.google.com/search?q=$1" ;;
	"sh") man 1 $1 ;;
	"c") man 3 $1 ;;
	"r") echo "?$1" | R --no-save ;;
	*) echo "Format not available. Searching Google."; xdg-open "http://www.google.com/search?q=$1%20$opt" ;;
esac

exit 0;

