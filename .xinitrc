/home/duzas/linuxStuff/.fehbg &

# 12 is the id of the touchpad. Check troubleshoot to get the scrolling input device id
xinput set-button-map 12 1 2 3 5 4 6 7 8 9 10 11 12 &

# https://wiki.archlinux.org/index.php/HiDPI
xrandr --dpi 220
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export QT_SCALE_FACTOR=2
export GDK_SCALE=2
export ELM_SCALE=1.5


# this MUST come last
exec i3
