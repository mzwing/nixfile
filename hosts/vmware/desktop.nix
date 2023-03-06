{ pkgs, ... }:

{
  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;
      desktopManager.plasma5.enable = true;
      displayManager.sddm.enable = true;
    };
    # Enable CUPS to print documents.
    printing.enable = true;
  };
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  # Enable network manager
  networking.networkmanager.enable = true;
  # Enable sound.
  sound.enable = true;
  # hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
