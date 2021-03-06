#!/bin/bash
BATTERY=$(upower -e | grep 'BAT')

while :
do
    BATTERY_PERCENTAGE=$(upower -i $BATTERY | grep percentage | awk '{ print $2 }'| sed s/'%'/''/g)
    CABLE=$(upower -d | grep -n2 line-power | grep online | awk '{ print $3 }')

    if [[ "$BATTERY_PERCENTAGE" -le "40" && $CABLE = "no" ]]; then
        notify-send "WARNING: Your battery is 40% below!" "NOTE: Keep it charged between 40% and 80% for better battery lifespan :)" -u critical;
        paplay Downloads/low.wav
    elif [[ "$BATTERY_PERCENTAGE" -ge "80" && $CABLE = "yes" ]]; then
        notify-send "Battery is above 80%" "NOTE: Keep it charged between 40% and 80% for better battery lifespan :) " -u low
        paplay Downloads/full.wav
    elif [[ "$BATTERY_PERCENTAGE" -ge "98" && $CABLE = "yes" ]]; then
        notify-send "Battery Full: 100%" "Please disconnect your charger!" -u low
		paplay Downloads/full.wav
    fi

sleep 30
done
