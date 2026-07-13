{ pkgs, ... }:

{
  home.packages = with pkgs; [ kitty ];

  xdg.configFile."kitty" = {
    source = ../dotfiles/kitty/.config/kitty;
    recursive = true;
  };
}
