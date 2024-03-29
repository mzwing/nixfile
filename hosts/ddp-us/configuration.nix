{ config, pkgs, ... }:

{
  imports = [
    ./nixos.nix
    ../../cachix.nix
  ];

  networking = {
    hostName = "ddp-us";
    useNetworkd = true;
    firewall = {
      allowedTCPPorts = [
        22
        443
      ];
    };
  };

  systemd = {
    network.networks.venet0 = {
      name = "venet0";
      networkConfig = {
        DHCP = "no";
        DefaultRouteOnDevice = "yes";
        ConfigureWithoutCarrier = "yes";
      };
      address = [ 
        "/24"
      ];
    };
    services.sing-box = {
      enable = true;
      description = "sing-box service";
      documentation = [
        "https://sing-box.sagernet.org"
      ];
      after = [
        "network.target"
        "nss-lookup.target"
      ];
      serviceConfig = {
        CapabilityBoundingSet = [ "CAP_NET_ADMIN" "CAP_NET_BIND_SERVICE" "CAP_SYS_PTRACE" "CAP_DAC_READ_SEARCH" ];
        AmbientCapabilities = [ "CAP_NET_ADMIN" "CAP_NET_BIND_SERVICE" "CAP_SYS_PTRACE" "CAP_DAC_READ_SEARCH" ];
        Restart = "on-failure";
        RestartSec = 10;
        LimitNOFILE = "infinity";
        ExecStart = "${pkgs.sing-box}/bin/sing-box -D /var/lib/sing-box -C /usr/local/etc/sing-box run";
        ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
      };
      wantedBy = [
        "multi-user.target"
      ];
    };
  };

  users = {
    users = {
      root.openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDfanSYN5epQylG/y/stltpjwDr2IX+TmT7ekhwaJ7nVy5Xr/6NYifudALQ7jrJYLD5fSIB6fp0d6WbSf2w7anHRD+re85IyD2BVscUtNPrbdv2xMARrqsThbzGyumBRCCz9ppOojeUuaOy94NTwlx/fRcQ2nTB7WlfSEEfVsgI+odBYoTa8braC93rXAE/CVV5jwYhuQN7huWARGjNVDVtQLdFg+cVHg+2KF3oAFd+wHF8QEqWucmJJIt8oL0CvSYDAOOHrqaIdv5tGUXOa+dxtrUiWpXQVNKC6EomqmmGK4dPe2GVHJjMaVHzYIOIZEIcuEm+sF8M2EL903XLvJ8aPN4+EfYGVF4fPk8Y9qnOqOXxZaRqW13+l28q6Wav1EyFKeEleXpH+rrPrFTI561GDgISFtJBZ1qsdWBWb6ivx7+Qri2ZIRM5A1Q4xNNmWnH+ST5zaKI6CVfwmb1Kr4DfWm8z2fdNZzzmPJnM1wItssmA4Nn/jL5mmF+Y1mec0EM= lockinwise lolite@MZWING-PC"
      ];
      mzwing = {
        isNormalUser = true;
        extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
        useDefaultShell = true;
        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDfanSYN5epQylG/y/stltpjwDr2IX+TmT7ekhwaJ7nVy5Xr/6NYifudALQ7jrJYLD5fSIB6fp0d6WbSf2w7anHRD+re85IyD2BVscUtNPrbdv2xMARrqsThbzGyumBRCCz9ppOojeUuaOy94NTwlx/fRcQ2nTB7WlfSEEfVsgI+odBYoTa8braC93rXAE/CVV5jwYhuQN7huWARGjNVDVtQLdFg+cVHg+2KF3oAFd+wHF8QEqWucmJJIt8oL0CvSYDAOOHrqaIdv5tGUXOa+dxtrUiWpXQVNKC6EomqmmGK4dPe2GVHJjMaVHzYIOIZEIcuEm+sF8M2EL903XLvJ8aPN4+EfYGVF4fPk8Y9qnOqOXxZaRqW13+l28q6Wav1EyFKeEleXpH+rrPrFTI561GDgISFtJBZ1qsdWBWb6ivx7+Qri2ZIRM5A1Q4xNNmWnH+ST5zaKI6CVfwmb1Kr4DfWm8z2fdNZzzmPJnM1wItssmA4Nn/jL5mmF+Y1mec0EM= lockinwise lolite@MZWING-PC"
        ];
      };
    };
    defaultUserShell = pkgs.zsh;
  };

  services = {
    openssh = {
      enable = true;
    };
    resolved.enable = false;
    dnsmasq = {
      enable = true;
      settings = {
        server = [
          "1.1.1.1"
          "8.8.8.8"
        ];
        no-resolv = true;
      };
    };
    nginx = {
      enable = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      virtualHosts."vaultwarden.mzwing.gq" = {
        forceSSL = true;
        sslCertificate = "/var/nginx/cert/mzwing.gq/mzwing.gq.cer";
        sslCertificateKey = "/var/nginx/cert/mzwing.gq/mzwing.gq.key";
        locations."/" = {
          proxyPass = "http://localhost:${toString config.services.vaultwarden.config.ROCKET_PORT}"; 
          proxyWebsockets = true;
        };
        locations."/notifications/hub" = {
          proxyPass = "http://localhost:3012";
          proxyWebsockets = true;
        };
        locations."/notifications/hub/negotiate" = {
          proxyPass = "http://localhost:${toString config.services.vaultwarden.config.ROCKET_PORT}";
          proxyWebsockets = true;
        };
      };
    };
    vaultwarden = {
      enable = true;
      config = {
        DOMAIN = "https://vaultwarden.mzwing.gq";
        WEBSOCKET_ENABLED =  true;
        SIGNUPS_ALLOWED = true;
        ROCKET_ADDRESS = "127.0.0.1";
        ROCKET_PORT = 8222;
        ROCKET_LOG = "critical";
        SMTP_HOST = "smtp.office365.com";
        SMTP_PORT = 587;
        SMTP_SECURITY = "starttls";
        SMTP_AUTH_MECHANISM = "Login";
        SMTP_FROM = "mzwing@lockinwize.onmicrosoft.com";
        SMTP_USERNAME = "mzwing@lockinwize.onmicrosoft.com";
        SMTP_FROM_NAME = "vaultwarden.mzwing.gq Vaultwarden server";
      };
      environmentFile = "/var/lib/vaultwarden.env";
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    screen
    sing-box
  ];

  programs = {
    vim.defaultEditor = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryFlavor = "tty";
    };
    zsh = {
      enable = true;
      ohMyZsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "git"
        ];
      };
      syntaxHighlighting.enable = true;
      autosuggestions.enable = true;
    };
  };

  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 5d";
      dates = "Sun 19:00";
    };
    settings = {
      # enable flakes
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      trusted-users = [ "root" "mzwing" ];
    };
  };
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.11";
}
