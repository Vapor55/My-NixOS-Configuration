{ config, pkgs, callPackage, ... }:

{
    services.xserver = {
        enable = true;
        desktopManager = {
            xterm.enable = false;
            xfce = {
                enable = true;
                noDesktop = true;
                enableXfwm = false;
            };
        };
        windowManager.i3.enable = true;
    };
    services.displayManager.defaultSession = "xfce";

    environment.systemPackages = with pkgs; [
      i3blocks
    ];
}
