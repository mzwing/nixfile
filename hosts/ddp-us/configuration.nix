{ config, pkgs, ... }:

{
  imports = [
    ./nixos.nix
    ../../cachix.nix
  ];
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
    "net.ipv4.conf.all.rp_filter" = 0;
    "net.ipv4.conf.default.rp_filter" = 0;
  };

  networking = {
    hostName = "ddp-us";
    useNetworkd = true;
    firewall = {
      allowedTCPPorts = [ 22 ];
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
      address = [ "/24" ];
    };
    services.sing-box = {
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
        RestartSec = 10;
        LimitNOFILE = "infinity";
      };
      path = [ pkgs.sing-box ];
      script = [
        "sing-box -D /var/lib/sing-box -C /etc/sing-box run"
      ];
      reload = [
        "kill -HUP $MAINPID"
      ];
      restartTriggers = [
        "on-failure"
      ];
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
      settings.PermitRootLogin = "yes";
    };
    resolved.enable = false;
    dnsmasq = {
      enable = true;
      settings = {
        server = [
          "1.1.1.1"
          "8.8.8.8"
        ];
        interface = "venet0";
        bind-interfaces = true;
        no-resolv = true;
      };
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

  system.stateVersion = "23.05";
}