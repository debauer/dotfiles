#!/bin/sh
INTERN="--output eDP1 --mode 1920x1080 --pos 1920x1080"
EXTERN1="--output DP2-2 --mode 3440x1440 --pos 0x0"
EXTERN2="--output DP2-3 --off"
EXTERN3="--output HDMI2 --off"
xrandr $INTERN $EXTERN1 $EXTERN2 $EXTERN3