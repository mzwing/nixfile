{ config, pkgs, ... }:

{
  networking = {
    hostName = "wsl";
    # Open ports in the firewall.
    firewall = {
      allowedTCPPorts = [ 22 ];
      allowedUDPPorts = [ 22 ];
      # Or disable the firewall altogether.
      # enable = false;
    };
  };
}
