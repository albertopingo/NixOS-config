{

  description = "My flake";

  inputs = {
    # Unstable NixPkgs
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # Chaotic's Nyx CachyOS Kernel
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    # Neovim Nightly
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = inputs@{ nixpkgs, home-manager, chaotic, neovim-nightly-overlay, ... }: {

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
            home-manager.extraSpecialArgs = { inherit inputs;};
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
          }

          chaotic.nixosModules.default
        ];
      };

    };

  };

}

