#!/bin/bash

if [ "$#" = 3 ]; then
	echo -e "<span color='$1' bgalpha='40%' fgalpha='40%'>\uE0B6</span><span color='$2' bgcolor='$1' bgalpha='40%' fgalpha='40%'>$3</span><span color='$1' bgalpha='40%' fgalpha='40%'>\uE0B4</span>"
elif [ "$#" = 4 ]; then
	echo -e "<span color='$1' bgalpha='40%' fgalpha='40%'>\uE0B6</span><span color='$2' bgcolor='$1' bgalpha='40%' fgalpha='40%'>$3</span><span color='$1' fgalpha='40%' bgcolor='$1' bgalpha='60%'>\uE0B4</span><span color='$2' bgcolor='$1' bgalpha='60%'> $4</span><span color='$1' fgalpha='60%'>\uE0B4</span>"
fi
