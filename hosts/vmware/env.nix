{ ... }:

{
  environment = {
    variables = {
      PUB_HOSTED_URL = "https://pub.flutter-io.cn";
      FLUTTER_STORAGE_BASE_URL = "https://storage.flutter-io.cn";
    };
    sessionVariables.NIXOS_OZONE_WL = "1";
  };
}