{ config, pkgs, ...}:

{
  # Enable the xdg-desktop-portal framework
  xdg.portal = {
    enable = true;
    lxqt.enable = true; # Enables the LXQt portal backend (xdg-desktop-portal-lxqt)
    
    # Optional: If you use additional portals like GTK or Wlr, you can declare extraPortals here
    # extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
