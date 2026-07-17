{ pkgs, ... }:

{
  users.users."gfors" = {
    isNormalUser = true;
    description = "nixos";
    extraGroups = [" docker" "networkmanager" "wheel" "video" "render"];
    shell = pkgs.zsh;
    packages = with pkgs; [
      kdePackages.kate
    ];
  };
  programs.zsh.enable = true;
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
    priority = 100;
  };

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/9d88bb68-6eed-481b-acc5-a204b3bcaecc";
      priority = 10;
    }
  ];

}
