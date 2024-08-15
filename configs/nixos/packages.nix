environment.systemPackages = with pkgs; [
  # System Packages
  pkgs.blueberry
  pkgs.bluez
  pkgs.ffmpeg-full
  pkgs.libnotify
  pkgs.networkmanagerapplet
  pkgs.udiskie
  
  # Display managers
  pkgs.sddm

  # Window Manager
  pkgs.cliphist
  pkgs.dunst
  pkgs.hyprland
  pkgs.hyprpicker
  pkgs.rofi-wayland
  pkgs.slurp
  pkgs.swappy
  pkgs.swaylock-effects
  pkgs.swww
  pkgs.waybar
  pkgs.wlogout
  pkgs.xdg-desktop-portal-hyprland

  # Terminal Related
  pkgs.btop
  pkgs.curl
  pkgs.fastfetch
  pkgs.figlet
  pkgs.fzf
  pkgs.htop
  pkgs.jq
  pkgs.neovim
  pkgs.parallel
  pkgs.ranger
  pkgs.ripgrep
  pkgs.rsync
  pkgs.tldr
  pkgs.tmux
  pkgs.toilet
  pkgs.vim 
  pkgs.zoxide
  pkgs.zsh


  # Programming Related
  pkgs.clang
  pkgs.conda
  pkgs.elixir
  pkgs.meson
  pkgs.poetry
  pkgs.rustup
  pkgs.rye
  pkgs.uv

  # Applications
  pkgs.docker
  pkgs.nvidia-docker
  pkgs.firefox
  pkgs.floorp
  pkgs.git
  pkgs.imagemagick
  pkgs.kitty
  pkgs.kdePackages.ark
  pkgs.kdePackages.dolphin
  pkgs.kdePackages.konsole
  pkgs.kdePackages.polkit-kde-agent-1
  pkgs.mpv
  pkgs.redis

  # Theming
  pkgs.nwg-look
  pkgs.libsForQt5.qt5ct
  pkgs.kdePackages.qt6ct

];
