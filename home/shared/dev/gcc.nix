{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gcc
    gnumake
    stdenv.cc.cc.lib
  ];
}
