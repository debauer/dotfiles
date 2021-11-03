#!/bin/bash

touchpadDevice="$(xinput list | grep 'TouchPad' | cut -d'=' -f2 | cut -d$'\t' -f1)"
current="$(xinput list-props ${touchpadDevice} | grep 'Device Enabled' | cut -d':' -f2 | tr -d '[:space:]')"

if [ "$current" -eq 1 ] ; then
    targetToggle="0"
    message="Touchpad off"
else
    targetToggle="1"
    message="Touchpad on"
fi

xinput set-prop "${touchpadDevice}" "Device Enabled" "$targetToggle"
notify-send "$message"
