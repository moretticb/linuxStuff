# 12 is the id of the touchpad. Check troubleshoot to get the scrolling input device id
xinput set-button-map 12 1 2 3 5 4 6 7 8 9 10 11 12 &

# https://wiki.archlinux.org/index.php/HiDPI
#xrandr --dpi 220
#export QT_AUTO_SCREEN_SCALE_FACTOR=0
#export QT_SCALE_FACTOR=2
#export GDK_SCALE=2
#export ELM_SCALE=1.5


#VBoxClient-all &
xmodmap ~/.Xmodmap


xrandr --newmode 1920x1080_60.00 172.80 1920 2040 2248 2576 1080 1081 1084 1118 -HSync +Vsync
xrandr --addmode Virtual-1 1920x1080_60.00
xrandr --output Virtual-1 --primary --mode 1920x1080_60.00 --pos 0x0 --rotate normal

nitrogen --set-zoom-fill --random /home/duzas/wallpapers &
picom &
exec i3

