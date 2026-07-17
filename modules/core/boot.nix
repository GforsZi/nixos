{ ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.resumeDevice = "/dev/disk/by-uuid/9d88bb68-6eed-481b-acc5-a204b3bcaecc";
  boot.kernelParams = [ "resume=UUID=9d88bb68-6eed-481b-acc5-a204b3bcaecc" ];

  boot.kernel.sysctl = {
    "vm.swappiness" = 100;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;
  };

}
