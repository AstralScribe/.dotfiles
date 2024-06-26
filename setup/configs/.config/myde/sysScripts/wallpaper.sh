#!/usr/bin/env sh


BASE_FOLDER="$HOME/.config/myde/wallpapers"
rasi_file="$HOME/.cache/myde/current_wallpaper.rasi"
used_wallpaper="$HOME/.cache/myde/used_wallpaper"
cache_file="$HOME/.cache/myde/current_wallpaper"


if [ ! -f $rasi_file ] ;then
    touch $rasi_file
    echo "* { current-image: url(\"$wallpaper_folder/default.jpg\", height); }" > "$rasi_file"
fi



selected=$( find "$BASE_FOLDER" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec basename {} \; | while read rfile
do
    echo -en "$rfile\x00icon\x1f$BASE_FOLDER/${rfile}\n"
done | rofi -dmenu -i -p "Wallpapers" -config ~/dotfiles/rofi/config-wallpaper.rasi)
if [ ! "$selected" ]; then
    echo "No wallpaper selected"
    exit
fi
# wal -q -i $wallpaper_folder/$selected

# ----------------------------------------------------- 
# Set the new wallpaper
# -----------------------------------------------------
# transition_type="wipe"
# transition_type="outer"
transition_type="random"

used_wallpaper="$BASE_FOLDER/$selected"
echo ":: Using swww"
swww img $used_wallpaper \
    --transition-bezier .43,1.19,1,.4 \
    --transition-fps=60 \
    --transition-type=$transition_type \
    --transition-duration=0.7 \
    --transition-pos "$( hyprctl cursorpos )"

