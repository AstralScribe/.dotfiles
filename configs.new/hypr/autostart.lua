hl.on("hyprland.start", function()
    -- XDPH stuff
    hl.exec_cmd("resetxdgportal.sh") -- reset XDPH for screenshare
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP") -- for XDPH
    hl.exec_cmd("dbus-update-activation-environment --systemd --all") -- for XDPH
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP") -- for XDPH

    -- Daemons
    hl.exec_cmd("/usr/lib/hyprpolkitagent/hyprpolkitagent")
    hl.exec_cmd("udiskie --no-automount --smart-tray")
    hl.exec_cmd("dunst")
    hl.exec_cmd("waybar")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("openrgb -p p1 --startminimized")

    -- Scripts
    hl.exec_cmd("wallpaper.sh init")
    hl.exec_cmd("batterynotify.sh") -- battery notification
    --hl.exec_cmd("~/.config/eww/scripts/start.sh")

    -- Clipboard
    hl.exec_cmd("wl-paste --type text --watch cliphist store") -- clipboard store text data
    hl.exec_cmd("wl-paste --type image --watch cliphist store") -- clipboard store image data

end)
