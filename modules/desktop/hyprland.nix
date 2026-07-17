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
    calc
    unzip
    thunar
    thunar-archive-plugin
    papirus-icon-theme
    lxappearance
    bibata-cursors
    wlogout
    sddm-astronaut
    polkit_gnome
  ];

  xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
    settings = {
      Theme = {
        CursorTheme = "Bibata-Modern-Ice";
        CursorSize = 20;
      };
    };
    extraPackages = with pkgs; [
      kdePackages.qtmultimedia
      kdePackages.qtsvg
      kdePackages.qt5compat
      ];
  };

  security.pam.services.hyprlock = {};
  programs.hyprlock.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
    settings = {
      Login = {
        IdleAction = "lock";
        IdleActionSec = "5min";
      };
    };
  };

  programs.dconf.enable = true;
  services.udisks2.enable = true;
  services.gvfs.enable = true;
}
