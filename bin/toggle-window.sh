#!/bin/bash

# run-or-cycle: Launch an app, focus its window, or cycle between its windows.
# Designed for KDE Plasma (Wayland) using kdotool.
#
# Usage: run-or-cycle.sh <window-class> <command>
#   window-class  The window class to search for (e.g. brave-browser, konsole, dolphin)
#   command       The command to launch the app if no window is found

# args
# -----------------------------------------------------------------
CLASS=$1
CMD=$2

if [ -z "$CLASS" ] || [ -z "$CMD" ]; then
    echo "Usage: toggle-window.sh <window-class> <command>" >&2
    exit 1
fi

# toggle logic
# -----------------------------------------------------------------

# Find all windows matching the class
WIDS=$(kdotool search --class "$CLASS" 2>/dev/null)
WIDS_ARRAY=($WIDS)

# No windows found — launch the app
if [ -z "$WIDS" ]; then
    setsid "$CMD" >/dev/null 2>&1 &
    exit 0
fi

# Get the currently active window
PREV_ACTIVE=$ACTIVE
ACTIVE=$(kdotool getactivewindow)

# if active window is one of the matching ones, minimize it
for id in "${WIDS_ARRAY[@]}"; do
    if [ "$id" = "$ACTIVE" ]; then
				kdotool windowstate --add MINIMIZED "$id"
        exit 0
    fi
done

# activate first one of the right class
for id in "${WIDS_ARRAY[@]}"; do
		kdotool windowactivate "$id"
		exit 0
done
