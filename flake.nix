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
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          chaotic.nixosModules.default
        ];
      };
    };
  };
}

