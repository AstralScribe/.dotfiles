#!/bin/bash

# Apply wallpaper using wal
wal -i $HOME/.cache/myde/current_wallpaper &&

# Start picom
picom --config ~/.config/picom/picom.conf &
