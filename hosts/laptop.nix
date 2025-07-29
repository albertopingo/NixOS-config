{ config, pkgs, ... }:

{
  networking.hostName = "laptop";


  services.xserver.videoDrivers = [
    "modesetting"
    "nvidia"
  ];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    modesetting.enable = true;
    nvidiaSettings = true;
    open = false; # Not supported by my GPU

    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
      offload.enable = true;
      offload.enableOffloadCmd = true; # Steam - 'nvidia-offload %command%'
      sync.enable = false;
    };
  };

}
