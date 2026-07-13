{ ... }:

{
  imports = [
    ./shell/zsh.nix
    ./shell/tmux.nix
    ./editor/neovim.nix
    ./terminal/kitty.nix
  ];

  home.stateVersion = "26.05";
  home.username = "gfors";
  home.homeDirectory = "/home/gfors";
}
