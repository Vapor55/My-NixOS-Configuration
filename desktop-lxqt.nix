{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the LXQt Desktop Environment
  services.xserver.desktopManager.lxqt.enable = true;

  # Exclude default packages from LXQt:
  environment.lxqt.excludePackages = with pkgs; [
    lxqt.qterminal
  ]; 
}
