{ inputs, config, pkgs, ... }:

let
  username = "biscotti";
  homeDir = "/home/${username}";
  dotfilesDir = "${homeDir}/.dotfiles";
  symlink = config.lib.file.mkOutOfStoreSymlink;
in

{
  home.username = username;
  home.homeDirectory = homeDir;
  home.stateVersion = "25.05";

  programs.bash = {
    enable = true;
    shellAliases = {
      nrsl = "sudo nixos-rebuild switch --impure --flake .#laptop";
      nrsd = "sudo nixos-rebuild switch --impure --flake .#laptop";
    };
  };

#   programs.neovim = {
# #     enable = true;
# # #     extraPackages = [
# # #       pkgs.ripgrep
# # #       pkgs.lazygit
# # #       pkgs.gcc
# # #       pkgs.gnumake
# # #       pkgs.nodejs_latest
# # #       pkgs.lua-language-server
# # #       pkgs.nixd
# # #     ];
# #
# #     plugins = with pkgs.vimPlugins; [
# #       lazy-nvim
# #    ];
#   };

  programs.neovim = {
      enable = true;
      package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };

#   home.file.".config/nvim".source = symlink "${dotfilesDir}/.config/nvim";
  xdg.configFile."nvim".source = symlink "${dotfilesDir}/.config/nvim";
  xdg.configFile."nvim".recursive = true;
}
