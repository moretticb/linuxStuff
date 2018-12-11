#!/bin/sh
man $1

if [ "$?" == "0" ]; then
	exit 0;
fi

echo "?$1" | R --no-save
