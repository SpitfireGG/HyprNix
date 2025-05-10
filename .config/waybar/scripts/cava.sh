#!/run/current-system/sw/bin/bash
# ~/.config/waybar/scripts/cava.sh

# Read CAVA output and format it for Waybar
while read -r line; do
  # CAVA outputs a line of bar heights (e.g., "12345678")
  # Convert to Waybar-compatible format using format-icons
  output=""
  for height in $(echo "$line" | grep -o .); do
    case $height in
      0) output="$output▁" ;;
      1) output="$output▂" ;;
      2) output="$output▃" ;;
      3) output="$output▄" ;;
      4) output="$output▅" ;;
      5) output="$output▆" ;;
      6) output="$output▇" ;;
      7) output="$output█" ;;
      *) output="$output " ;; # Fallback for unexpected values
    esac
  done
  echo "$output"
done
