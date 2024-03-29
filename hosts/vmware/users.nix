{ config, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users.mzwing = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" ]; # Enable ‘sudo’ for the user.
      useDefaultShell = true;
    };
    defaultUserShell = pkgs.zsh;
  };
}
