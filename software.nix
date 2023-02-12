{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    google-chrome
    vscode
    vscode-fhs
    noto-fonts
    noto-fonts-extra
    noto-fonts-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    nodejs-19_x
    electron_22
    firefox
    git
    aria
    appimage-run
    libsForQt5.kleopatra
    libsForQt5.ark
    libsForQt5.plasma-browser-integration
    gnome.gnome-boxes
    deno
    bun
    direnv
    whitesur-icon-theme
    whitesur-gtk-theme
    element-desktop
    amule
    krita
    vlc
    nixpkgs-fmt
    cachix
    yarn
    nvfetcher
    rocketchat-desktop
    rustup
    node2nix
    # go
    go
    # gomobile
    # wine
    winetricks
    wine
    winePackages.fonts
    winePackages.base
    winePackages.waylandFull
    gcc
    python311
    # flutter
    flutter
    clang
    cmakeWithGui
    ninja
    pkg-config
    android-studio
    # nur
    config.nur.repos.rewine.ttf-ms-win10
    config.nur.repos.linyinfeng.icalingua-plus-plus
    config.nur.repos.crazazy.js.pnpm
    config.nur.repos.YisuiMilena.hmcl-bin
  ];
  programs = {
    partition-manager.enable = true;
    vim.defaultEditor = true;
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
    # anbox.enable = true;
    vmware.guest.enable = true;
    waydroid.enable = true;
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
  };
}
