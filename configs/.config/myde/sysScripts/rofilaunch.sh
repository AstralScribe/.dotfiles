#!/usr/bin/env sh


source $XDG_CONFIG_HOME/myde/parameters.conf
source $XDG_CONFIG_HOME/myde/sysScripts/globals.sh

# Variables

[[ "${rofiScale}" =~ ^[0-9]+$ ]] || rofiScale=10
[ "${hypr_border}" -eq 0 ] && elem_border="10" || elem_border=$(( hypr_border * 2 ))

# Overrides
r_scale="configuration {font: \"JetBrainsMono Nerd Font ${rofiScale}\";}"
r_override="window {border: ${hypr_width}px; border-radius: ${wind_border}px;} element {border-radius: ${elem_border}px;}"
i_override="$(gsettings get org.gnome.desktop.interface icon-theme | sed "s/'//g")"
i_override="configuration {icon-theme: \"${i_override}\";}"

while getopts dr option; do
    case $option in
        d) runner="drun"
            ;;
        r) runner="run"
            ;;
        *) echo "Invalid"
            exit 1;
            ;;
    esac
done

# Rofi
rofi -show "$runner" \
    -theme-str "${r_scale}" \
    -theme-str "${r_override}" \
    -theme-str "${i_override}" \
    -config "${roconf}"
