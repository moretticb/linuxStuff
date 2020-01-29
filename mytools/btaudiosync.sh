#!/bin/sh

BLUEZCARD=`pactl list cards short | egrep -o bluez.*[[:space:]]`
#pactl set-card-profile $BLUEZCARD a2dp
#pactl set-card-profile $BLUEZCARD hsp
#pactl set-card-profile $BLUEZCARD a2d
pactl set-card-profile $BLUEZCARD a2dp_sink
pactl set-card-profile $BLUEZCARD headset_head_unit
pactl set-card-profile $BLUEZCARD a2dp_sink
