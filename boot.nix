{ config, pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        #  efiSysMountPoint = "/boot/efi";
      };
      systemd-boot.enable = true;
    };
    #  kernelPackages = pkgs.linuxKernel.kernels.linux_zen;
  };
}
