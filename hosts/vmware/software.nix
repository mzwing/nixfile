{ config, pkgs, ... }:

{
  imports = [
    ./env.nix
    # Include services
    ../../services/code-server.nix
    # ../../services/openssh.nix
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
    nodejs
    deno
    electron
    git
    aria
    appimage-run
    gnomeExtensions.appindicator
    gnome.gnome-tweaks
    gnome.gnome-backgrounds
    whitesur-gtk-theme
    whitesur-icon-theme
    sing-box
    qq
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
    seahorse.enable = true;
    gnome-terminal.enable = true;
    gnome-disks.enable = true;
    file-roller.enable = true;
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
}
