#!/usr/bin/env bash

# Terminate already running instances
killall -q dunst

# Wait until the processes have been shut down
while pgrep -u $UID -x dunst >/dev/null; do sleep 1; done

# Launch bar
dunst &
notify-send "Dunst has started!"
