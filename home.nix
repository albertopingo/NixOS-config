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
      nrsl = "sudo nixos-rebuild switch --impure --flake ${homeDir}/nixos-config/.#laptop";
      nrsd = "sudo nixos-rebuild switch --impure --flake ${homeDir}/nixos-config/.#desktop";
    };
  };

  programs.neovim = {
      enable = true;
      package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };

#   home.file.".config/nvim".source = symlink "${dotfilesDir}/.config/nvim";
  xdg.configFile."nvim".source = symlink "${dotfilesDir}/.config/nvim";
  xdg.configFile."nvim".recursive = true;
}
