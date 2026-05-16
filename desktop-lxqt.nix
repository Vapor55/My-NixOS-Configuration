{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the LXQt Desktop Environment
  services.xserver.desktopManager.lxqt.enable = true;

  # Enable LXQt Wayland Session
  environment.systemPackages = with pkgs; [
    lxqt.lxqt-wayland-session
  ];

  # Enable the LabWC Wayland Compositor
  programs.labwc.enable = true;

  # Exclude default packages from LXQt:
  environment.lxqt.excludePackages = with pkgs; [
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
