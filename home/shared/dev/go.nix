{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ go ];

  home.sessionVariables = {
    GOPATH = "${config.home.homeDirectory}/go";
  };
}
