{ config, pkgs, inputs, ... }:

{

  # Imports

  imports = [
    # Separated Packages
    ./Programs/xdg-userdirs.nix
    ./Programs/zsh.nix
    ./Programs/gtk.nix
    ./Programs/cursor-icon.nix
  ];

  # Home Manager configuration

  home.username = "hitori";
  home.homeDirectory = "/home/hitori";
  home.stateVersion = "26.05"; # Or your desired NixOS release version

  # Home Manager Packages

  home.packages = with pkgs; [
    htop
    btop
    firefox
    discord
    vscode
    pear-desktop
    cava
    tigervnc
    git
    fastfetch
    onefetch
    baobab
    gimp
    audacious
    vlc
    temurin-bin
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
