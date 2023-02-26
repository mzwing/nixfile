{ config, pkgs, ... }:

{
  imports = [
    ../../services/code-server.nix
    ../../services/openssh.nix
  ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    aria
    bun
    code-server
    nixpkgs-fmt
    direnv
    nvfetcher
    gcc
    python311
  ];
  programs = {
    vim.defaultEditor = true;
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # mtr.enable = true;
    gnupg.agent = {
      enable = true;
      # enableSSHSupport = true;
    };
    ssh.startAgent = true;
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
  services.code-server = {
    user = "nixos";
    # Add pwsh.exe to PATH!(x)
    # extraEnvironment.PATH = "$PATH:\"/mnt/c/Users/Lockinwise Lolite/AppData/Local/Microsoft/WindowsApps/\"";
  };
  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 5d";
      dates = "Sun 19:00";
    };
    settings = {
      # mirrors
      substituters = [
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://mirror.sjtu.edu.cn/nix-channels/store"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
      ];
      # enable flakes
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
  };
  nixpkgs.config = {
    allowUnfree = true;
  };
}
