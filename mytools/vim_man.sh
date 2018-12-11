#!/bin/sh
clear

echo "> $1"
echo -e "\nLANGUAGES:"
echo "  0 - Google search"
echo "  1 - Shell"
echo "  2 - C"
echo "  3 - R"

echo -e "\nLast: $(cat /tmp/vim_lastdoc 2>/dev/null)"

opt=0
read -p "> " opt

if [ "$opt" == "" ]; then
	echo "using last option: $(cat /tmp/vim_lastdoc)"
	opt=$(cat /tmp/vim_lastdoc)
fi

echo $opt > /tmp/vim_lastdoc

case $opt in
	0) xdg-open "http://www.google.com/search?q=$1" ;;
	1) man 1 $1 ;;
	2) man 3 $1 ;;
	3) echo "?$1" | R --no-save ;;
	*) xdg-open "http://www.google.com/search?q=$1" ;;
esac

exit 0;

