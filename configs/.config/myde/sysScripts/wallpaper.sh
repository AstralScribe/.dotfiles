#!/usr/bin/env bash


source $XDG_CONFIG_HOME/myde/parameters.conf
source $XDG_CONFIG_HOME/myde/sysScripts/globals.sh

# check swww daemon
swww query &> /dev/null
if [ $? -ne 0 ] ; then
    swww-daemon --format xrgb &
    swww query && swww restore
fi


# Variables
BASE_FOLDER="$XDG_CONFIG_HOME/myde/wallpapers"
cache_file="$HOME/.cache/myde/current_wallpaper"
cache_sqre_file="$HOME/.cache/myde/cw.sqre"
cache_quad_file="$HOME/.cache/myde/cw.quad"
cache_blur_file="$HOME/.cache/myde/cw.blur"
roconf="$XDG_CONFIG_HOME/rofi/select-wallpaper.rasi"
transition_type="random"
# transition_type="wipe"
# transition_type="outer"


[[ "${rofiScale}" =~ ^[0-9]+$ ]] || rofiScale=10
[ "${hypr_border}" -eq 0 ] && elem_border="10" || elem_border=$(( hypr_border * 2 ))

# Overrides
r_scale="configuration {font: \"JetBrainsMono Nerd Font ${rofiScale}\";}"
r_override="window {border: ${hypr_width}px; border-radius: ${wind_border}px;} element {border-radius: ${elem_border}px;}"

#---------------------#
# Set transition_type #
#---------------------#

if [ "$1" == "init" ]; then
    swww img $cache_file \
    --transition-bezier .43,1.19,1,.4 \
    --transition-fps=60 \
    --transition-type=$transition_type \
    --transition-duration=0.7 \
    --transition-pos "$( hyprctl cursorpos )"
    exit 0;
fi



selected=$( find "$BASE_FOLDER" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec basename {} \; | while read rfile
do
    echo -en "$rfile\x00icon\x1f$BASE_FOLDER/${rfile}\n"
done | rofi -dmenu \
    -theme-str "${r_scale}" \
    -theme-str "${r_override}" \
    -config "${roconf}"
)
if [ ! "$selected" ]; then
    echo "No wallpaper selected"
    exit 0;
fi
# wal -q -i $wallpaper_folder/$selected

used_wallpaper="$BASE_FOLDER/$selected"

rm -rf $cache_file
ln -s $used_wallpaper $cache_file

magick $cache_file \
    -thumbnail "800x800^" \
    -gravity center \
    -extent "800x800" \
    $cache_sqre_file

magick $cache_sqre_file \
    -size 800x800 xc:white \
    -fill "rgba(0,0,0,0.7)" \
    -draw "polygon 700,800 800,800 800,0 750,0" \
    -fill black \
    -draw "polygon 800,800 800,0 750,800" \
    -alpha Off \
    -compose CopyOpacity \
    -composite "/tmp/cw.png" \
    && mv "/tmp/cw.png" $cache_quad_file 

magick $cache_file -blur "50x30" $cache_blur_file

swww img $cache_file \
    --transition-bezier .43,1.19,1,.4 \
    --transition-fps=60 \
    --transition-type=$transition_type \
    --transition-duration=0.7 \
    --transition-pos "$( hyprctl cursorpos )"
