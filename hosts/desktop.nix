{ config, pkgs, ... }:

{
  networking.hostName = "desktop";

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    modesetting.enable = true;
    nvidiaSettings = true;
    open = false; # Not supported by my GPU
  };

}
