{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Media,Sink,Socket";
        Experimental = true;
      };
    };
  }; 
  services.blueman.enable = true;
}
