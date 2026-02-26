{ config, pkgs, ... }:

{
  # GTK Theme, Icons and Fonts configurations at Home Manager

  gtk = {
    enable = true;

    theme = {
      package = pkgs.kdePackages.breeze-gtk;
      name = "Breeze-Dark";
    };

    iconTheme = {
      package = pkgs.colloid-icon-theme;
      name = "Colloid-Dark";
    };

    font = {
      name = "Noto Sans";
      size = 9;
    };
  };
}
