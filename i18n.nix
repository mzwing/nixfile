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
          fcitx5-chinese-addons
          fcitx5-rime
        ];
        enableRimeData = true;
      };
    };
  };
  environment = {
    variables = {
      PUB_HOSTED_URL = "https://pub.flutter-io.cn";
      FLUTTER_STORAGE_BASE_URL = "https://storage.flutter-io.cn";
      PNPM_HOME = "/home/mzwing/.local/share/pnpm";
    };
  };
}
