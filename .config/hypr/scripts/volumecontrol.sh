#!/usr/bin/env sh

tagVol="notifyvol"

function notify_vol {
    vol=$(pamixer --get-volume)
    sink=$(pamixer --get-default-sink | awk '{print $NF}' | tr -d '"')
    mute=$(pamixer --get-mute)

    angle=$(((vol + 2) / 5 * 5))
    ico="~/.config/dunst/iconvol/vol-${angle}.svg"

    if [ "$mute" = true ]; then
        dunstify "Muted" -i "$ico" -a "$sink" -u low -r 91190 -t 800
    elif [ "$vol" -ne 0 ]; then
        dunstify -i "$ico" -a "$sink" -u low -h string:x-dunst-stack-tag:"$tagVol" \
        -h int:value:"$vol" "Volume: ${vol}%" -r 91190 -t 800
    else
        dunstify -i "$ico" "Volume: ${vol}%" -a "$sink" -u low -r 91190 -t 800
    fi
}

case $1 in
    i) pamixer -i 5
       ;;
    d) pamixer -d 5
       ;;
    m) pamixer -t
       ;;
    *)
       echo "volumecontrol.sh [action]"
       echo "i -- increase volume [+5]"
       echo "d -- decrease volume [-5]"
       echo "m -- mute [x]"
       ;;
esac

notify_vol

