{ ... }:

{
  imports = [
  ./apps/spotify.nix
  ./apps/vesktop.nix
  ./apps/alsa-tools.nix
  ./apps/browsers.nix
  ./apps/mpv.nix
  ./apps/obs.nix

  ./shell/tmux.nix
  
  ./terminal/kitty.nix
  ];
}
