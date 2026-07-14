{ pkgs, ... }:

{
  home.packages = with pkgs; [
    php85
    php85Packages.composer
  ];
}
