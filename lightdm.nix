{ config, pkgs, ... }:

{
  # Optional: Configure display manager (e.g., sddm is popular with LXQt)
  services.xserver.displayManager.lightdm = {
    enable = true;

    # Setting gtk as the greeter
    greeters.gtk.enable = true;

    # Example of having background as a particular color
    # background = "#ffa07a";

    # Example of the default image background (must be an absolute path)
    background = ./Assets/Wallpapers/Saki-Tenma/wp11393211-saki-tenma-wallpapers.png;
  };
}