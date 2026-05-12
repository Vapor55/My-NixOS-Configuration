{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the LXQt Desktop Environment
  services.xserver.desktopManager.lxqt.enable = true;
  
  # Optional: Configure display manager (e.g., sddm is popular with LXQt)
  services.xserver.displayManager.lightdm = {
    enable = true;

    # Setting gtk as the greeter
    greeters.gtk.enable = true;

    # Example of having background as a particular color
    background = "#ffa07a";

    # Example of the default image background (must be an absolute path)
    #background = pkgs.nixos-artwork.wallpapers.simple-dark-gray-bottom.gnomeFilePath;
  };
}
