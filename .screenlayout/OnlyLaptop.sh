#!/bin/sh
INTERN="--output eDP1 --mode 1920x1080 --pos 1920x1080"
EXTERN1="--output DP2-2 --off"
EXTERN2="--output DP2-3 --off"
EXTERN2="--output HDMI2 --off"
xrandr $INTERN $EXTERN1 $EXTERN2