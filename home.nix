{ config, pkgs, inputs, ... }:

{

  # Imports

  imports = [
    # Separated Packages
    ./Programs/xdg-userdirs.nix
    ./Programs/zsh.nix
    ./Programs/gtk.nix
  ];

  # Home Manager configuration

  home.username = "guilherme";
  home.homeDirectory = "/home/guilherme";
  home.stateVersion = "26.05"; # Or your desired NixOS release version

  # Home Manager Packages

  home.packages = with pkgs; [
    htop
    btop
    brave
    pear-desktop
    discord
    vscode
    gcc
    git
    fastfetch
    onefetch
    ncdu
    kdePackages.filelight
    sxiv
    gimp
    audacious
    mpv
    gamemode
    gamescope
    mangohud
    lutris
  ];

  # Home Manager Switcher

  programs.home-manager.enable = true;

  # Enable unfree Packages

  nixpkgs.config.allowUnfree = true;
}
