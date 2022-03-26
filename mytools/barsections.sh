#!/bin/bash

L="&#57526;" #"\uE0B6"
R="&#57524;" #"\uE0B4"

if [ "$#" = 3 ]; then
	echo -e "<span color='$1' bgalpha='40%' fgalpha='40%'>$L</span><span color='$2' bgcolor='$1' bgalpha='40%' fgalpha='40%'>$3</span><span color='$1' bgalpha='40%' fgalpha='40%'>$R</span>"
elif [ "$#" = 4 ]; then
	echo -e "<span color='$1' bgalpha='40%' fgalpha='40%'>$L</span><span color='$2' bgcolor='$1' bgalpha='40%' fgalpha='40%'>$3</span><span color='$1' fgalpha='40%' bgcolor='$1' bgalpha='60%'>$R</span><span color='$2' bgcolor='$1' bgalpha='60%'> $4</span><span color='$1' fgalpha='60%'>$R</span>"
fi
