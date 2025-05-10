#!/run/current-system/sw/bin/bash

# swayprop: Click a window to get its app_id, title, etc. in Hyprland
# Dependencies: slurp, jq, hyprctl (or swaymsg)

point=$(slurp -p -f "%x %y")
[ -z "$point" ] && exit 1

# Get Hyprland's client list
clients=$(hyprctl clients -j)

# Find the window at the clicked point
window=$(echo "$clients" | jq -r --argjson point "${point// /,}" \
  '.[] | select(.at[0] <= $point[0] and $point[0] <= .at[0] + .size[0] and .at[1] <= $point[1] and $point[1] <= .at[1] + .size[1])')

if [ -z "$window" ]; then
  echo "No window found at $point"
  exit 1
fi

# Extract details
app_id=$(echo "$window" | jq -r '.class')
title=$(echo "$window" | jq -r '.title')
pid=$(echo "$window" | jq -r '.pid')

echo "App ID: $app_id"
echo "Title: $title"
echo "PID: $pid"
