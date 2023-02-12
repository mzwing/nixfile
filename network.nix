{ config, pkgs, ... }:

{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    # Configure network proxy if necessary
    proxy = {
      default = "http://192.168.249.1:20172";
      noProxy = "127.0.0.1,localhost";
    };
    # Open ports in the firewall.
    firewall = {
      allowedTCPPorts = [ 22 4444 ];
      allowedUDPPorts = [ 22 ];
    #   Or disable the firewall altogether.
    #   enable = false;
    };
  };
}
