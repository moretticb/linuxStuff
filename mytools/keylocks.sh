#!/bin/bash

$HOME/linuxStuff/mytools/barmsg.sh "$(xset q | grep Caps | sed "s/[0-9:]//g" | sed -E "s/(Caps|Num|Scroll) Lock[ ]+on/\n\1\n/g" | grep ^[A-Z] | tr "\n" " ")"
