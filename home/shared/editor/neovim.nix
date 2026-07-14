{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
    ripgrep
    fd
    tree-sitter
  ];

  xdg.configFile."nvim" = {
    source = "${config.home.homeDirectory}/dotfiles/nvim/.config/nvim";
    recursive = true;
  };
}
