{ config, pkgs,... }:

{
  imports =
    [ 
      /etc/nixos/hardware-configuration.nix
      ./packages.nix
      ./modules/bluetooth.nix
      ./modules/env.nix
      ./modules/nvidia.nix
      ./modules/sound.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "Thinker-Laptop"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };


  # Services
  services.xserver.enable = false;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.printing.enable = true;
  services.xserver.xkb = {
    layout = "in";
    variant = "eng";
  };

  # Desktop session
  programs.hyprland.enable = true;


  # User Account
  users = {
    defaultUserShell = pkgs.zsh;

    users.mayank = {
      isNormalUser = true;
      description = "mayank";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
      ];
    };
  };

  # Dynamic linking
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];

  # Settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  system.stateVersion = "24.05";
}
