#!/bin/sh

cat "$HOME/linuxStuff/troubleshoot/$(ls $HOME/linuxStuff/troubleshoot | dmenu -l 10)" | dmenu -l 15
