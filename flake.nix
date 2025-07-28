{

  description = "A very basic flake";

  inputs = {
    # Unstable NixPkgs
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    # Chaotic's Nyx CachyOS Kernel
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
  };

  outputs = { self, nixpkgs, chaotic }: {

    nixosConfigurations = {

      # sudo nixos-rebuild switch --impure --flake .#desktop
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/desktop.nix
          ./common.nix
          chaotic.nixosModules.default
        ];
      };

      # sudo nixos-rebuild switch --impure --flake .#laptop
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/laptop.nix
          ./common.nix
          chaotic.nixosModules.default
        ];
      };

    };

  };

}

