{ config, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users.mzwing = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
      ];
      useDefaultShell = true;
    };
    defaultUserShell = pkgs.zsh;
  };
}
