{ pkgs, ...}:

{
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      "log-driver" = "json-file";
      "log-opts" = {
        "max-size" = "10m";
        "max-file" = "3";
      };
    };
    autoPrune = {
      enable = true;
      dates = "weekly";
      flags = [ "--all" ];
    };
  };

  systemd.services.docker.wantedBy = pkgs.lib.mkForce [];
  virtualisation.docker.enableOnBoot = false;

  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
