#!/bin/sh
INTERN="--output eDP1 --mode 1920x1080 --pos 1920x1080"
EXTERN1="--output DP2-2 --primary --mode 1920x1080 --pos 0x0"
EXTERN2="--output DP2-3 --primary --mode 1920x1080 --pos 1920x0"
xrandr $INTERN $EXTERN1 $EXTERN2