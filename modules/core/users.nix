{ pkgs, ... }:

{
  users.users."gfors" = {
    isNormalUser = true;
    description = "nixos";
    extraGroups = [" docker" "networkmanager" "wheel" "video" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      kdePackages.kate
    ];
  };
  programs.zsh.enable = true;
}
