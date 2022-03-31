#!/bin/sh

dmenu_path | dmenu "$@" -fn "Ubuntu-$($HOME/linuxStuff/mytools/get_ws_fontsize.sh)" | ${SHELL:-"/bin/sh"} &
