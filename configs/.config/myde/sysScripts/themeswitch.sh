#!/usr/bin/env bash

source $XDG_CONFIG_HOME/myde/parameters.conf
source $XDG_CONFIG_HOME/myde/sysScripts/globals.sh

# Variables
themePath="$XDG_CONFIG_HOME/myde/themes"
gtk4ThemeDir=~/.local/share/themes
roconf="$XDG_CONFIG_HOME/rofi/select-theme.rasi"


[[ "${rofiScale}" =~ ^[0-9]+$ ]] || rofiScale=10
[ "${hypr_border}" -eq 0 ] && elem_border="10" || elem_border=$(( hypr_border * 2 ))

# Overrides
r_scale="configuration {font: \"JetBrainsMono Nerd Font ${rofiScale}\";}"
r_override="window {border: ${hypr_width}px; border-radius: ${wind_border}px;} element {border-radius: ${elem_border}px;}"

selectedTheme=$(find $themePath -maxdepth 0 -type d  -exec ls {} \; | 
    rofi -dmenu \
    -theme-str "${r_scale}" \
    -theme-str "${r_override}" \
    -config "${roconf}"
)

if [ ! -z "${selectedTheme}" ] ; then

    # Setting base paths and hypr
    selectedThemeDir="$themePath/$selectedTheme"

    gtkTheme="$(grep 'gsettings set org.gnome.desktop.interface gtk-theme' "${selectedThemeDir}/hypr.theme" | 
        awk -F "'" '{print $(NF - 1)}')"
    gtkIcon="$(grep 'gsettings set org.gnome.desktop.interface icon-theme' "${selectedThemeDir}/hypr.theme" | 
        awk -F "'" '{print $(NF - 1)}')"
    gtkMode="$(grep 'gsettings set org.gnome.desktop.interface color-scheme' "${selectedThemeDir}/hypr.theme" | 
        awk -F "'" '{print $(NF - 1)}')"

    cp "$selectedThemeDir/hypr.theme" "$XDG_CONFIG_HOME/hypr/themes/theme.conf"


    # QT/GTK theme edits
    sed -i "/^icon_theme=/c\icon_theme=${gtkIcon}" "$XDG_CONFIG_HOME/qt5ct/qt5ct.conf"
    sed -i "/^icon_theme=/c\icon_theme=${gtkIcon}" "$XDG_CONFIG_HOME/qt6ct/qt6ct.conf"

    sed -i "/^gtk-theme-name=/c\gtk-theme-name=${gtkTheme}" "$XDG_CONFIG_HOME/gtk-3.0/settings.ini"
    sed -i "/^gtk-icon-theme-name=/c\gtk-icon-theme-name=${gtkIcon}" "$XDG_CONFIG_HOME/gtk-3.0/settings.ini"

    sed -i "/^gtkMode=/c\gtkMode=${gtkMode}" "$XDG_CONFIG_HOME/myde/parameters.conf"

    rm -rf "$XDG_CONFIG_HOME/gtk-4.0"
    ln -s "${gtk4ThemeDir}/${gtkTheme}/gtk-4.0" "$XDG_CONFIG_HOME/gtk-4.0"


    # Theme copies
    cp "$selectedThemeDir/kvantum/kvconfig.theme" "$XDG_CONFIG_HOME/Kvantum/myde/myde.kvconfig" 
    cp "$selectedThemeDir/kvantum/svg.theme" "$XDG_CONFIG_HOME/Kvantum/wallbash/myde.svg" 
    cp "$selectedThemeDir/rofi.theme" "$XDG_CONFIG_HOME/rofi/theme.rasi"
    cp "$selectedThemeDir/waybar.theme" "$XDG_CONFIG_HOME/waybar/theme.css"
    cp "$selectedThemeDir/qt.theme" "$XDG_CONFIG_HOME/qt5ct/colors.conf"
    cp "$selectedThemeDir/qt.theme" "$XDG_CONFIG_HOME/qt6ct/colors.conf"


    # Inits
    pkill waybar
    waybar > /dev/null 2>&1 &
    notify-send -a "t1" -i "$HOME/.config/dunst/icons/hyprdots.png" " $selectedTheme"
fi
