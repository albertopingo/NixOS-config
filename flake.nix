{

  description = "A very basic flake";

  inputs = {
    # Unstable NixPkgs
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # Chaotic's Nyx CachyOS Kernel
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
  };

  outputs = inputs@{ nixpkgs, home-manager, chaotic, ... }: {

    nixosConfigurations = {

      # sudo nixos-rebuild switch --impure --flake .#desktop
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/desktop.nix
          ./common.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.biscotti = ./home.nix;
            home-manager.backupFileExtension = "backup";

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }

          chaotic.nixosModules.default
        ];
      };

      # sudo nixos-rebuild switch --impure --flake .#laptop
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/laptop.nix
          ./common.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.biscotti = ./home.nix;
            home-manager.backupFileExtension = "backup";

            home-manager.extraSpecialArgs = { inherit inputs;};


            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }

          chaotic.nixosModules.default
        ];
      };

    };

  };

}

