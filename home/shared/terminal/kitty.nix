{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  programs.kitty = {
    enable = true;

    font = {
      name = "FiraCode Nerd Font";
      size = 9.0;
    };

    themeFile = "tokyo_night_storm";

    settings = {
      background_opacity = "0.85";
      background_blur = "32";
    };
  };
}
