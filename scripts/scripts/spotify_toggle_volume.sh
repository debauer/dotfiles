#!/bin/sh
LANGUAGE="en_US"

app_name="spotify"

current_sink_num=''
sink_num_check=''
app_name_check=''
silent_volume=20000

sink_info=$(pactl list sink-inputs | egrep "(Sink Input|Volume|application\.name)" | grep spotify -B 2)
sink_num_check=$(echo "$sink_info" | head -n 1 | cut -d \# -f 2)
sink_volume=$(echo "$sink_info" | grep Volume | cut -d / -f 1 | cut -d " " -f 3)

echo "$sink_num_check" "$sink_volume"

if [[ $sink_volume != $silent_volume ]]; then
  echo $sink_volume > /tmp/spot_volume
  pactl set-sink-input-volume "$sink_num_check" "$silent_volume"
else
  pactl set-sink-input-volume "$sink_num_check" "$(cat /tmp/spot_volume)"
fi


