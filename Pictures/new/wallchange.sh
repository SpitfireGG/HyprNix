#!/run/current-system/sw/bin/bash

# Path to the directory containing the wallpapers
wallpaper_dir="/home/spitfire/Pictures/new"

# Array to store the list of wallpapers
wallpapers=()

# Populate the wallpapers array with the files from the directory

echo "established connection"
while IFS= read -r -d '' file; do
    wallpapers+=("$file")
done < <(find "$wallpaper_dir" -type f \( -name "*.png" -o -name "*.jpg" \) -print0)

# Check if there are wallpapers available
if [[ ${#wallpapers[@]} -eq 0 ]]; then
    echo "No wallpapers found in the directory: $wallpaper_dir"
    exit 1
fi

# Index to keep track of the current wallpaper
current_wallpaper_index=0

# Loop to change the wallpaper indefinitely
while true; do
    # Get the current wallpaper path
    current_wallpaper="${wallpapers[$current_wallpaper_index]}"
    
    echo "current wallpaper : $current_wallpaper"
    # Set the wallpaper using swww with the specified transition
    swww img  "$current_wallpaper"

    # Increment the wallpaper index
    ((current_wallpaper_index++))

    # Reset the index if it reaches the end of the wallpapers array
    if [[ $current_wallpaper_index -ge ${#wallpapers[@]} ]]; then
        current_wallpaper_index=0
    fi

    # Add a delay between wallpaper changes (in seconds)
    sleep 3
done

