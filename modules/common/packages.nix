{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    stow
    fastfetch
    btop
  ];
}
