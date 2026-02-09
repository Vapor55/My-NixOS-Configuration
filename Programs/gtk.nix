{ config, pkgs, ... }:

{
  # GTK Theme, Icons, Cursor and Fonts configurations at Home Manager

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 16;
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.colloid-gtk-theme;
      name = "Colloid-Dark";
    };

    iconTheme = {
      package = pkgs.reversal-icon-theme;
      name = "Reversal-Dark";
    };

    font = {
      name = "Noto Sans";
      size = 9;
    };
  };
}