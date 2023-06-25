{ pkgs, ... }:

{
  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;
      # Gnome only
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;

      # DDE only
      # desktopManager.deepin.enable = true;

      # KDE only
      # desktopManager.plasma5.enable = true;
      # displayManager.sddm.enable = true;
    };

    gnome = {
      gnome-user-share.enable = true;
      gnome-online-accounts.enable = true;
      gnome-browser-connector.enable = true;
      gnome-settings-daemon.enable = true;
      core-utilities.enable = true;
      core-shell.enable = true;
      core-developer-tools.enable = true;
      gnome-keyring.enable = true;
      core-os-services.enable = true;
    };

    # Enable CUPS to print documents.
    printing.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    # DDE only
    # deepin = {
    # dde-daemon.enable = true;
    # dde-api.enable = true;
    # app-services.enable = true;
    # };
  };
  qt.platformTheme = "gnome";
  # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  # Enable network manager
  networking.networkmanager.enable = true;
  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
}
