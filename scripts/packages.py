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
    "blueman",                                              # bluetooth manager gui
    "brightnessctl",                                        # screen brightness control
    "udiskie",                                              # manage removable media
    "wlr-randr",                                            # xrandr for wayland
    "ffmpeg",                                               # audio/video utility
    "docker",                                               # containerization

# --------------------------------------------------------- // Display Manager
    "sddm",                                                 # display manager for KDE plasma
    "qt5-quickcontrols",                                    # for sddm theme ui elements
    "qt5-quickcontrols2",                                   # for sddm theme ui elements
    "qt5-graphicaleffects",                                 # for sddm theme effects

# --------------------------------------------------------- // Window Manager
    "hyprland",                                             # wlroots-based wayland compositor
    "dunst",                                                # notification daemon
    "rofi",                                                 # application launcher
    "waybar",                                               # system bar
    "hyprpaper",                                            # wallpaper
    "hyprlock",                                             # lock screen
    "hyprpicker",                                           # color picker
    "hyprshot",                                             # screenshot
    "cliphist",                                             # clipboard manager

# --------------------------------------------------------- // Dependencies
    "polkit-gnome",                                         # authentication agent
    "xdg-desktop-portal-hyprland",                          # xdg desktop portal for hyprland
    "pacman-contrib",                                       # for system update check
    "parallel",                                             # for parallel processing
    "jq",                                                   # for json processing
    "imagemagick",                                          # for image processing
    "libnotify",                                            # for notifications

# --------------------------------------------------------- // Theming
    "nwg-look",                                             # gtk configuration tool
    "qt5ct",                                                # qt5 configuration tool
    "qt6ct",                                                # qt6 configuration tool
    "kvantum",                                              # svg based qt6 theme engine
    "kvantum-qt5",                                          # svg based qt5 theme engine
    "qt5-wayland",                                          # wayland support in qt5
    "qt6-wayland",                                          # wayland support in qt6

# --------------------------------------------------------- // Applications
    "firefox",                                              # browser
    "ghostty",                                              # terminal
    "thunar",                                               # file manager
    "ark",                                                  # kde file archiver
    "neovim",                                               # terminal text editor
    "mpv",                                                  # video player
    "openssh",                                              # ssh
    "valkey",                                               # in-memory database

# --------------------------------------------------------- // Shell
    "zsh",                                                  # shell
    "fastfetch",                                            # system information fetch tool
    # "tmux",                                               # terminal multiplexer
    "zoxide",                                               # faster cd
    "tldr",                                                 # man with examples
    "rsync",                                                # better cp and scp
    "meson",                                                # python based build system
    "fzf",                                                  # fuzzy search
    "btop",                                                 # system monitor
    "figlet",                                               # ascii based art
    "ripgrep",                                              # better grep


# --------------------------------------------------------- // Programming Language
    "uv",                                                   # python-package manager
    "rye",                                                  # python-project manager
    "rustup",                                               # rust package manager
    "clang",                                                # C/C++ compiler
    "lld",                                                  # LLVM dynamic linker
    "lldb",                                                 # LLVM debugger
    "cuda",                                                 # Nvidia Cuda Language
    "cudnn",                                                # Nvidia Cuda Deep Neutral Network
    "go",                                                   # Go Programming Language
    "gopls",                                                # Go Language Server
    "ninja",                                                # C/C++ build system
    "cmake",                                                # C/C++ build system creator
    "llvm",                                     
    "ccache",                                               # Cache creator for faster builds
    "godot",                                                # Game engine
    "scons",                                                # Build script for godot


# --------------------------------------------------------- // Fonts
    "unicode-emoji",                                        # Emojis
    "gnu-free-fonts",                                       # GNU Fonts
    "noto-fonts",                                           # Google Noto Fonts
    "noto-fonts-cjk",                                       # Google Noto Fonts
    "noto-fonts-emoji",                                     # Google Noto Fonts
    "noto-fonts-extra",                                     # Google Noto Fonts
    "ttf-cascadia-code",                                    # Cascadia Fonts
    "ttf-cascadia-code-nerd",                               # Cascadia Fonts
    "ttf-cascadia-mono-nerd",                               # Cascadia Fonts
    "otf-firamono-nerd",                                    # FiraCode Fonts
    "ttf-firacode-nerd",                                    # FiraCode Fonts
    "ttf-jetbrains-mono",                                   # JetBrains Fonts
    "ttf-jetbrains-mono-nerd",                              # JetBrains Fonts
    "ttf-victor-mono-nerd",                                 # VictorMono Fonts
    "ttf-mononoki-nerd",
    "ttf-jigmo",                                            # Japanese Fonts
    "ttf-baekmuk",                                          # Korean Fonts
]
