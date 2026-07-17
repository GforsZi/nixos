{ pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vulkan-loader
      vulkan-validation-layers
      vpl-gpu-rt
      libvdpau-va-gl
    ];
  };

  hardware.cpu.intel.updateMicrocode = true;
}
