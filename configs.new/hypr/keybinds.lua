-- Variables
local hl = _G.hl
local mod = "SUPER"
local term = "ghostty"
local file = "thunar"
local browser = "zen"

-- Window/Session actions
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + delete", hl.dsp.exit())
hl.bind(mod .. " + W", hl.dsp.window.float({ action = "toggle" }))
hl.bind("ALT + RETURN", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mod .. " + Backspace", hl.dsp.exec_cmd("logoutlaunch.sh 1"))
hl.bind("CTRL + ALT + W", hl.dsp.exec_cmd("killall waybar || waybar"))

-- Application shortcuts
hl.bind(mod .. " + T", hl.dsp.exec_cmd(term))
hl.bind(mod .. " + E", hl.dsp.exec_cmd(file))
hl.bind(mod .. " + F", hl.dsp.exec_cmd(browser))
hl.bind("CTRL + SHIFT + Escape", hl.dsp.exec_cmd("sysmonlaunch.sh"))

-- GenAI
hl.bind(mod .. " + ALT + C", hl.dsp.exec_cmd("pkill -x chromium"))
hl.bind(mod .. " + C", hl.dsp.exec_cmd("chromium --ozone-platform=wayland --app=https://chatgpt.com"))
hl.bind(mod .. " + SHIFT + C", hl.dsp.exec_cmd("chromium --ozone-platform=wayland --app=https://claude.ai/"))

-- Rofi is toggled on/off if you repeat the key presses
hl.bind(mod .. " + A", hl.dsp.exec_cmd("pkill -x rofi || rofilaunch.sh -d"))
hl.bind(mod .. " + R", hl.dsp.exec_cmd("pkill -x rofi || rofilaunch.sh -r"))

-- Audio control
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("volumecontrol.sh -o m"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("volumecontrol.sh -i m"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("volumecontrol.sh -o d"), { locked = true, repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("volumecontrol.sh -o i"), { locked = true, repeating = true })

-- Media control
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Brightness control
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnesscontrol.sh i"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnesscontrol.sh d"), { locked = true, repeating = true })

-- Screenshot/Screencapture
hl.bind(mod .. " + P", hl.dsp.exec_cmd("screenshot.sh p"))
hl.bind(mod .. " + CTRL + P", hl.dsp.exec_cmd("screenshot.sh sf"))
hl.bind(mod .. " + ALT + P", hl.dsp.exec_cmd("screenshot.sh m"))
hl.bind("print", hl.dsp.exec_cmd("screenshot.sh p"))

-- Exec custom scripts
hl.bind(mod .. " + SHIFT + T", hl.dsp.exec_cmd("pkill -x rofi || themeswitch.sh"))
hl.bind(mod .. " + SHIFT + W", hl.dsp.exec_cmd("pkill -x rofi || wallpaper.sh"))
hl.bind(mod .. " + V", hl.dsp.exec_cmd("pkill -x rofi || cliphist.sh c"))
hl.bind(mod .. " + SHIFT + K", hl.dsp.exec_cmd("keyboardswitch.sh"))

-- Move focus with mainMod + arrow keys
hl.bind(mod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + J", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "down" }))
hl.bind("ALT + Tab", hl.dsp.focus({ direction = "down" }))

-- Workspaces
for i = 1, 10 do
  local key = i % 10
  hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
  hl.bind(mod .. " + ALT + " .. key, hl.dsp.window.move({ workspace = i, silent = true }))
end

-- Switch workspaces relative to the active workspace with mainMod + CTRL + [←→]
hl.bind(mod .. " + CTRL + right", hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mod .. " + CTRL + left", hl.dsp.focus({ workspace = "r-1" }))
-- move to the first empty workspace instantly with mainMod + CTRL + [↓]
hl.bind(mod .. " + CTRL + down", hl.dsp.focus({ workspace = "empty" }))

-- Move active window to a relative workspace with mainMod + CTRL + ALT + [←→]
hl.bind(mod .. " + CTRL + ALT + Right", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind(mod .. " + CTRL + ALT + Left", hl.dsp.window.move({ workspace = "r-1" }))

-- Move active window around current workspace with mainMod + SHIFT + CTRL [←→↑↓]
hl.bind(mod .. " + SHIFT + CTRL + Left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mod .. " + SHIFT + CTRL + Right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mod .. " + SHIFT + CTRL + Up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mod .. " + SHIFT + CTRL + Down", hl.dsp.window.move({ direction = "down" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e+1" }))


-- Move/Resize windows with mainMod + LMB/RMB and dragging
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
-- bindm = $mainMod, mouse:272, movewindow
-- bindm = $mainMod, mouse:273, resizewindow
-- bindm = Super, Z, movewindow
-- bindm = Super, X, resizewindow


-- Special workspaces (scratchpad)
hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special", silent = true }))
hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special())

