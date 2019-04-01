#!/bin/bash

weekDay="$(date | cut -d" " -f 1)"

if [ "$weekDay" == "Mon" ]; then
	dayline=$(links -dump http://www.puspsc.usp.br/cardapio/ | grep -n Segunda-feira | cut -d: -f1)
	nextdayline=$(links -dump http://www.puspsc.usp.br/cardapio/ | grep -n Terça-feira | cut -d: -f1)
elif [ "$weekDay" == "Tue" ]; then
	dayline=$(links -dump http://www.puspsc.usp.br/cardapio/ | grep -n Terça-feira | cut -d: -f1)
	nextdayline=$(links -dump http://www.puspsc.usp.br/cardapio/ | grep -n Quarta-feira | cut -d: -f1)
elif [ "$weekDay" == "Wed" ]; then
	dayline=$(links -dump http://www.puspsc.usp.br/cardapio/ | grep -n Quarta-feira | cut -d: -f1)
	nextdayline=$(links -dump http://www.puspsc.usp.br/cardapio/ | grep -n Quinta-feira | cut -d: -f1)
elif [ "$weekDay" == "Thu" ]; then
	dayline=$(links -dump http://www.puspsc.usp.br/cardapio/ | grep -n Quinta-feira | cut -d: -f1)
	nextdayline=$(links -dump http://www.puspsc.usp.br/cardapio/ | grep -n Sexta-feira | cut -d: -f1)
elif [ "$weekDay" == "Fri" ]; then
	dayline=$(links -dump http://www.puspsc.usp.br/cardapio/ | grep -n Sexta-feira | cut -d: -f1)
	nextdayline=$(links -dump http://www.puspsc.usp.br/cardapio/ | grep -n Sábado-feira | cut -d: -f1)
elif [ "$weekDay" == "Sat" ]; then
	dayline=$(links -dump http://www.puspsc.usp.br/cardapio/ | grep -n Sábado | cut -d: -f1)
	nextdayline=$(links -dump http://www.puspsc.usp.br/cardapio/ | grep -n "sem aviso" | cut -d: -f1)
else
	exit 0
fi

size=$((( ( $nextdayline - $dayline ) / 2 )))
dayline=$((( $dayline - $size )))
nextdayline=$((( $nextdayline - $size )))

hour=$(date | cut -c 12-13)
if [ $hour -lt 14 ]; then
	links -dump http://www.puspsc.usp.br/cardapio/ | sed -n "$dayline, $nextdayline p" | cut -c 20-50 | dmenu -l 9 -p "Almoço" -nb "#CCCCCC" -nf "#666666"
else
	links -dump http://www.puspsc.usp.br/cardapio/ | sed -n "$dayline, $nextdayline p" | cut -c 51-83 | dmenu -l 9 -p "Jantar"
fi
