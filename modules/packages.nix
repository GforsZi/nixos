{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wget
    neovim
    brave
    kitty
    home-manager
    git
  ];
}
