{ pkgs, ... }:

{
  programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    (pkgs.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    }))
    mako
    awww
    rofi
    wireplumber
    pavucontrol
    brightnessctl
    wlsunset
    grim
    slurp
    wl-clipboard
    thunar
    thunar-archive-plugin
    papirus-icon-theme
    lxappearance
    bibata-cursors
    wlogout
  ];

  xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
    settings = {
      Login = {
        IdleAction = "suspend";
        IdleActionSec = "15min";
      };
    };
  };

  programs.dconf.enable = true;
}
