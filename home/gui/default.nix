{ ... }:

{
  imports = [
  ./apps/spotify.nix
  ./apps/vesktop.nix
  ./apps/alsa_tools.nix
  ./apps/browsers.nix

  ./shell/tmux.nix
  
  ./terminal/kitty.nix
  ];
}
