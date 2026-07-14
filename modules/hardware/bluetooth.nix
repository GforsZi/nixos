{ pkgs, ... }:

{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;  # otomatis nyala saat boot, tidak perlu enable manual tiap kali
  };

  services.blueman.enable = true;  # GUI tray untuk pairing device
}
