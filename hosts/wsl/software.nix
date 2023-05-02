{ config, pkgs, ... }:

{
  imports = [
    # ../../services/code-server.nix
    ../../services/openssh.nix
  ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    bun
    nixpkgs-fmt
    direnv
    nvfetcher
    gcc
  ];
  programs = {
    vim.defaultEditor = true;
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # mtr.enable = true;
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
      # mirrors
      substituters = [
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://mirror.sjtu.edu.cn/nix-channels/store"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
      ];
      # enable flakes
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      trusted-users = [ "root" "mzwing" ];
    };
  };
  nixpkgs.config = {
    allowUnfree = true;
  };
}
