{ pkgs, ... }:

{
  # Set your time zone.
  time.timeZone = "Asia/Shanghai";
  # Select internationalisation properties.
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "us";
    useXkbConfig = true; # use xkbOptions in tty.
  };
  i18n = {
    defaultLocale = "zh_CN.UTF-8";
    inputMethod = {
      enabled = "fcitx5";
      fcitx5 = {
        addons = with pkgs; [
          # Chinese
          fcitx5-chinese-addons
          fcitx5-rime
          # Japanese
          fcitx5-mozc
        ];
      };
    };
  };
  services.xserver = {
    layout = "cn";
    libinput.enable = true;
  };
  environment.systemPackages = with pkgs; [
    noto-fonts
    noto-fonts-extra
    noto-fonts-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];
}
