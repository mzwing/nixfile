{ ... }:

{
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
