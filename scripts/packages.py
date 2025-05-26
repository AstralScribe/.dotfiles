packages = [
# --------------------------------------------------------- // System
    "pipewire",                                             # audio/video server
    "pipewire-alsa",                                        # pipewire alsa client
    "pipewire-audio",                                       # pipewire audio client
    "pipewire-jack",                                        # pipewire jack client
    "pipewire-pulse",                                       # pipewire pulseaudio client
    "gst-plugin-pipewire",                                  # pipewire gstreamer client
    "wireplumber",                                          # pipewire session manager
    "pavucontrol-qt",                                       # pulseaudio volume control
    "pamixer",                                              # pulseaudio cli mixer
    "networkmanager",                                       # network manager
    "network-manager-applet",                               # network manager system tray utility
    "bluez",                                                # bluetooth protocol stack
    "bluez-utils",                                          # bluetooth utility cli
    "blueberry",                                            # bluetooth manager gui
    "brightnessctl",                                        # screen brightness control
    "udiskie",                                              # manage removable media
    "wlr-randr",                                            # xrandr for wayland
    "sof-firmware",
    "ffmpeg",
    "docker",

# --------------------------------------------------------- // Display Manager
    "sddm",                                                 # display manager for KDE plasma
    "qt5-quickcontrols",                                    # for sddm theme ui elements
    "qt5-quickcontrols2",                                   # for sddm theme ui elements
    "qt5-graphicaleffects",                                 # for sddm theme effects

# --------------------------------------------------------- // Window Manager
    "hyprland",                                             # wlroots-based wayland compositor
    "dunst",                                                # notification daemon
    "rofi-wayland",                                         # application launcher
    "waybar",                                               # system bar
    "swww",                                                 # wallpaper
    "swaylock-effects-git",                                 # lock screen
    "wlogout",                                              # logout menu
    "hyprpicker",                                           # color picker
    "slurp",                                                # region select for screenshot/screenshare
    "swappy",                                               # screenshot editor
    "cliphist",                                             # clipboard manager
    "grim",                                                 # screenshot app

# --------------------------------------------------------- // Dependencies
    "polkit-kde-agent",                                     # authentication agent
    "xdg-desktop-portal-hyprland",                          # xdg desktop portal for hyprland
    "pacman-contrib",                                       # for system update check
    "parallel",                                             # for parallel processing
    "jq",                                                   # for json processing
    "imagemagick",                                          # for image processing
    # "qt5-imageformats",                                   # for dolphin image thumbnails
    # "ffmpegthumbs",                                       # for dolphin video thumbnails
    # "kde-cli-tools",                                      # for dolphin file type defaults
    "libnotify",                                            # for notifications

# --------------------------------------------------------- // Theming
    "nwg-look",                                             # gtk configuration tool
    "qt5ct",                                                # qt5 configuration tool
    "qt6ct",                                                # qt6 configuration tool
    "kvantum",                                              # svg based qt6 theme engine
    "kvantum-qt5",                                          # svg based qt5 theme engine
    "qt5-wayland",                                          # wayland support in qt5
    "qt6-wayland",                                          # wayland support in qt6
    # "bibata-cursor-theme",                                  # cursors list

# --------------------------------------------------------- // Applications
    "firefox",                                              # browser
    "floorp-bin",                                           # browser
    "kitty",                                                # terminal
    "thunar",                                              # file manager
    "ark",                                                  # kde file archiver
    "vim",                                                  # terminal text editor
    "neovim",                                               # terminal text editor
    "mpv",                                                  # video player
    "openssh",                                              # ssh
    "p7zip",                                                # zip
    "redis",                                                # in-memory database

# --------------------------------------------------------- // Shell
    "zsh",                                                  # shell
    "fastfetch",                                            # system information fetch tool
    "tmux",                                                 # terminal multiplexer
    "zoxide",                                               # faster cd
    "tldr",                                                 # man with examples
    "uv",                                                   # python-package manager
    "rye",                                                  # python-project manager
    "rustup",                                               # rust package manager
    "rsync",
    "ranger",
    "meson",
    "htop",
    "btop",
    "elixir",
    "figlet",
    "ripgrep",

    

# --------------------------------------------------------- // Fonts
    "gnu-free-fonts",
    "otf-firamono-nerd",
    "noto-fonts",
    "noto-fonts-extra",
    "ttf-cascadia-code",
    "ttf-cascadia-code-nerd",
    "ttf-cascadia-mono-nerd",
    "ttf-firacode-nerd",
    "ttf-font-awesome",
    "ttf-hanazone",
    "ttf-jetbrains-mono",
    "ttf-jetbrains-mono-nerd",
    "ttf-mononoki-nerd",
    "ttf-victor-mono-nerd",
    "unicode-emoji",
    "noto-fonts-cjk",
    "noto-fonts-emoji",
    "noto-fonts-extra",
]
