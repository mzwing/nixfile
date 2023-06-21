{ config, pkgs, ... }:

{
  imports = [
    ./env.nix
    # Include services
    ../../services/code-server.nix
    ../../services/openssh.nix
    ../../services/nix-config.nix
    # Include cachix based sources
    ../../cachix.nix
  ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # Nix Official pkgs
  environment.systemPackages = with pkgs; [
    vim
    wget
    microsoft-edge-dev
    nodejs
    deno
    electron
    git
    aria
    appimage-run
    libsForQt5.kleopatra
    sing-box
    gcc
    python3Full
    # nix
    direnv
    nixpkgs-fmt
    cachix
    yarn2nix
    nvfetcher
    rnix-lsp
    # go
    go
    gomobile
    # wine
    winetricks
    wine
    winePackages.fonts
    winePackages.base
    winePackages.waylandFull
    # flutter
    flutter
    gtk3
    gtk3-x11
    clang
    cmake
    ninja
    pkg-config
    android-tools
    # NUR pkgs
    config.nur.repos.rewine.ttf-ms-win10
    config.nur.repos.linyinfeng.icalingua-plus-plus
    config.nur.repos.crazazy.js.pnpm
  ];
  services.code-server.user = "mzwing";
  programs = {
    partition-manager.enable = true;
    vim.defaultEditor = true;
    firefox = {
      enable = true;
      languagePacks = [
        "en-US"
        "zh-CN"
      ];
    };
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # mtr.enable = true;
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
  virtualisation = {
    vmware.guest.enable = true;
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
    android_sdk.accept_license = true;
    permittedInsecurePackages = [
      "nodejs-16.20.0"
      "nodejs-14.21.3"
      "openssl-1.1.1t"
      "openssl-1.1.1u"
    ];
  };
}
