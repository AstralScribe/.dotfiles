{
  hardware.opengl = {
    enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
  }
  
  nvidiaSettings = true;
  package = config.boot.kernelPackages.nvidiaPackages.stable;
}
