{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the LXQt Desktop Environment
  services.xserver.desktopManager.lxqt = {
    enable = true;
    # Optional: explicitly add wayland packages if needed
    extraPackages = [ pkgs.lxqt.lxqt-wayland-session ];
  };

  # Make sure labwc and related tools are installed
  environment.systemPackages = with pkgs; [
    labwc
    labwc-tweaks
    lxqt.lxqt-wayland-session
    # Other useful LXQt components
    lxqt.pcmanfm-qt
  ];

  # Exclude default packages from LXQt:
  environment.lxqt.excludePackages = with pkgs; [
    lxqt.openbox
    lxqt.qterminal
  ];
  
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
