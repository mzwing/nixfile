{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;
      desktopManager.plasma5.enable = true;
      displayManager.sddm.enable = true;
      layout = "cn";
      libinput.enable = true;
    };
    # Enable CUPS to print documents.
    printing.enable = true;
    openssh.enable = true;
    flatpak.enable = true;
    # cachix
    cachix-agent.enable = true;
    # cachix-watch-store = {
    #   enable = true;
    #   compressionLevel = 9;
    # };
    # code-server
    code-server = {
      enable = true;
      extraEnvironment = {
        EXTENSIONS_GALLERY = "{ \"serviceUrl\": \"https://marketplace.visualstudio.com/_apis/public/gallery\", \"cacheUrl\": \"https://vscode.blob.core.windows.net/gallery/index\", \"itemUrl\": \"https://marketplace.visualstudio.com/items\", \"controlUrl\": \"\", \"recommendationsUrl\": \"\" }";
      };
      auth = "none";
      # hashedPassword = "";
      host = "0.0.0.0";
      user = "mzwing";
    };
  };
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
