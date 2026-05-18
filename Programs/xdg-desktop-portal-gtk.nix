{ config, pkgs, ...}:

{
  # Enable the xdg-desktop-portal framework
  xdg.portal = {
    enable = true;
    gtk.enable = true; # Enables the GTK portal backend (xdg-desktop-portal-gtk)
    
    # Optional: If you use additional portals like GTK or Wlr, you can declare extraPortals here
    # extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}