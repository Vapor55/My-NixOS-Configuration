{ config, pkgs, ... }:

{
  # Enable Plasma 
  services.desktopManager.plasma6.enable = true;

  # Display Manager

  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;

      # package = pkgs.kdePackages.sddm;
      theme = "catppuccin-macchiato-mauve";
    };

    autoLogin = {
      enable = true;
      user = "guilherme";
    };
  };

  # GVFS, UDisks2 and Polkit needed for Dolphin

  services = {
    gvfs.enable = true;
    udisks2.enable = true;
  };

  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    # SDDM Theme

    (catppuccin-sddm.override {
      flavor = "macchiato";
      accent = "mauve";
      font  = "Noto Fonts";
      fontSize = "9";
      background = "${./Assets/Background/virtual_bg_01_unit06.png}";
      loginBackground = true;
    })
  ];

  # KDE Connect

  programs.kdeconnect.enable = true;

  # Enable KDE Connect in Firewall

  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
    allowedUDPPortRanges = [{ from = 1714; to = 1764; }];
  };
}