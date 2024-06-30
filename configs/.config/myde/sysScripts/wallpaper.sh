#!/usr/bin/env sh

# check swww daemon
swww query &> /dev/null
if [ $? -ne 0 ] ; then
    swww-daemon --format xrgb &
    swww query && swww restore
fi


BASE_FOLDER="$HOME/.config/myde/wallpapers"
rasi_file="$HOME/.cache/myde/current_wallpaper.rasi"
used_wallpaper="$HOME/.cache/myde/used_wallpaper"
cache_file="$HOME/.cache/myde/current_wallpaper"

#---------------------#
# Set transition_type #
#---------------------#
# transition_type="wipe"
# transition_type="outer"
transition_type="random"

if [ ! -f $rasi_file ] ;then
    touch $rasi_file
    echo "* { current-image: url(\"$wallpaper_folder/default.jpg\", height); }" > "$rasi_file"
fi


while getopts "ic" option ; do
    case $option in
        i ) # initializing cache file
            status="init"
            ;;
        c ) # continue
            status="continue"
            ;;
        * ) # invalid option
            echo "... invalid option ..."
            echo "$(basename "${0}") -[option]"
            echo "i : init"
            echo "c : continue"
            exit 1 ;;
    esac
done

if [ "$status" == "init" ]; then
    swww img $cache_file \
    --transition-bezier .43,1.19,1,.4 \
    --transition-fps=60 \
    --transition-type=$transition_type \
    --transition-duration=0.7 \
    --transition-pos "$( hyprctl cursorpos )"

elif [ "$status" == "continue" ]; then
    selected=$( find "$BASE_FOLDER" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec basename {} \; | while read rfile
    do
        echo -en "$rfile\x00icon\x1f$BASE_FOLDER/${rfile}\n"
    done | rofi -dmenu -i -p "Wallpapers" -config ~/dotfiles/rofi/config-wallpaper.rasi)
    if [ ! "$selected" ]; then
        echo "No wallpaper selected"
        exit
    fi
    # wal -q -i $wallpaper_folder/$selected

    used_wallpaper="$BASE_FOLDER/$selected"

    rm -rf $cache_file
    ln -s $used_wallpaper $cache_file

    swww img $cache_file \
        --transition-bezier .43,1.19,1,.4 \
        --transition-fps=60 \
        --transition-type=$transition_type \
        --transition-duration=0.7 \
        --transition-pos "$( hyprctl cursorpos )"
fi
