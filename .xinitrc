/home/duzas/linuxStuff/.fehbg &

# 12 is the id of the touchpad. Check troubleshoot to get the scrolling input device id
xinput set-button-map 12 1 2 3 5 4 6 7 8 9 10 11 12 &

# this MUST come last
exec i3
