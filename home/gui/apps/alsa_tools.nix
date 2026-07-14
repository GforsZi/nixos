{ pkgs, ... }:

{
  home.packages = with pkgs; [
    alsa-tools
  ];
}
