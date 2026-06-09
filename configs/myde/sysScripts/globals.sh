#!/usr/bin/env bash

# Univerals
if [ "$(printenv HYPRLAND_INSTANCE_SIGNATURE)" ]; then
    hypr_border="$(hyprctl -j getoption decoration:rounding | jq '.int')"
    hypr_width="$(hyprctl -j getoption general:border_size | jq '.int')"
else
    hypr_border=10
    hypr_width=2
fi
wind_border=$(( hypr_border * 3 ))


# Wlogout
if [ "$(printenv HYPRLAND_INSTANCE_SIGNATURE)" ]; then
    x_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width')
    y_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .height')
    hypr_scale=$(hyprctl -j monitors | jq '.[] | select (.focused == true) | .scale' | sed 's/\.//')
else
    x_mon=1920
    y_mon=1080
    hypr_scale=100
fi


# Rofi
roconf="$XDG_CONFIG_HOME/rofi/select-launcher.rasi"
