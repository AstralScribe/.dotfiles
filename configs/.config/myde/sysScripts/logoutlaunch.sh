#!/usr/bin/env sh

if pgrep -x "wlogout" > /dev/null
then
    pkill -x "wlogout"
    exit 0
fi



source $XDG_CONFIG_HOME/myde/parameters.conf
hypr_border="$(hyprctl -j getoption decoration:rounding | jq '.int')"
hypr_width="$(hyprctl -j getoption general:border_size | jq '.int')"

[ -z "${1}" ] || wlogoutStyle="${1}"
wLayout="$XDG_CONFIG_HOME/wlogout/layout_${wlogoutStyle}"
wlTmplt="$XDG_CONFIG_HOME/wlogout/style_${wlogoutStyle}.css"

if [ ! -f "${wLayout}" ] || [ ! -f "${wlTmplt}" ] ; then
    echo "ERROR: Config ${wlogoutStyle} not found..."
    wlogoutStyle=1
    wLayout="$XDG_CONFIG_HOME/wlogout/layout_${wlogoutStyle}"
    wlTmplt="$XDG_CONFIG_HOME/wlogout/style_${wlogoutStyle}.css"
fi


#// detect monitor res

x_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width')
y_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .height')
hypr_scale=$(hyprctl -j monitors | jq '.[] | select (.focused == true) | .scale' | sed 's/\.//')


#// scale config layout and style

case "${wlogoutStyle}" in
    1)  wlColms=6
        export mgn=$(( y_mon * 28 / hypr_scale ))
        export hvr=$(( y_mon * 23 / hypr_scale )) ;;
    2)  wlColms=2
        export x_mgn=$(( x_mon * 35 / hypr_scale ))
        export y_mgn=$(( y_mon * 25 / hypr_scale ))
        export x_hvr=$(( x_mon * 32 / hypr_scale ))
        export y_hvr=$(( y_mon * 20 / hypr_scale )) ;;
esac


#setting parameters

export fntSize=$(( y_mon * 2 / 100 ))
export active_rad=$(( hypr_border * 5 ))
export button_rad=$(( hypr_border * 8 ))
[ "${gtkMode}" == "prefer-dark" ] && export BtnCol="white" || export BtnCol="black"


#// eval config files

wlStyle="$(envsubst < $wlTmplt)"


#// launch wlogout

wlogout -b "${wlColms}" -c 0 -r 0 -m 0 --layout "${wLayout}" --css <(echo "${wlStyle}") --protocol layer-shell

