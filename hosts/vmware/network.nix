{ ... }:

{
  networking = {
    hostName = "vmware";
    # Configure network proxy if necessary
    proxy = {
      default = "http://169.254.170.88:20172";
      noProxy = "127.0.0.1,localhost,::1";
    };
    # Open ports in the firewall.
    firewall = {
      allowedTCPPorts = [ 22 4444 5173 ];
      allowedUDPPorts = [ 22 ];
      # Or disable the firewall altogether.
      # enable = false;
    };
  };
}
