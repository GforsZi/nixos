{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
    ripgrep
    fd
  ];

  xdg.configFile."nvim" = {
    source = ../dotfiles/nvim/.config/nvim;
    recursive = true;
  };
}
