CONFIG_FILES="$HOME/.config/waybar/config.jsonc $HOME/.config/waybar/style.css"
trap "pkill waybar" EXIT
while true; do
   waybar &
  inotifywait -e modify $CONFIG_FILES
  pkill waybar
done
