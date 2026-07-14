{ ... }:

{
  imports = [
  ./shell/zsh.nix

  ./cli_tools/opencode.nix
  ./cli_tools/yazi.nix

  ./dev/direnv.nix
  ./dev/gcc.nix
  ./dev/git.nix
  ./dev/nodejs.nix
  ./dev/php.nix
  ./dev/go.nix

  ./editor/neovim.nix
  ];
}
