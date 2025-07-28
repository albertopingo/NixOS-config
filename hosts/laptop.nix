{ config, pkgs, ... }:

{
  networking.hostName = "laptop";


  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.latest;

    modesetting.enable = true;

    nvidiaSettings = true;

    # Not supported by my GPU
    open = false;

    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
      offload.enable = true;
      sync.enable = false;
    };
  };

}
