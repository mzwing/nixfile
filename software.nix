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
    zsh
    noto-fonts
    noto-fonts-extra
    noto-fonts-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    nodejs-19_x
    electron_20
    firefox
    git
    aria
    appimage-run
    open-vm-tools
    libsForQt5.kleopatra
    libsForQt5.ark
    gnome.gnome-boxes
    deno
    bun
    v2ray
    direnv
    whitesur-icon-theme
    whitesur-gtk-theme
    element-desktop
    darling-dmg
    amule
    krita
    vlc
    code-server
    nixpkgs-fmt
    yarn
    nvfetcher
    rocketchat-desktop
    # wine
    winetricks
    wine
    winePackages.fonts
    winePackages.base
    winePackages.waylandFull
    # flutter
    flutter
    clang
    cmakeWithGui
    ninja
    pkg-config
    androidStudioPackages.beta
    # nur
    # config.nur.repos.rewine.v2raya
    config.nur.repos.rewine.ttf-ms-win10
    config.nur.repos.linyinfeng.icalingua-plus-plus
    config.nur.repos.crazazy.js.pnpm
    # config.nur.repos.xddxdd.xray
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
      ];
      # enable flakes
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
  };
  nixpkgs.config.allowUnfree = true;
}
