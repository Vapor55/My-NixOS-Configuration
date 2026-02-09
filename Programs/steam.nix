{ config, pkgs, ... }:

{
  # Steam

  programs.steam = {
    enable = true;
    # gamescopeSession.enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # Allow Steam license

  nixpkgs.config.allowUnfree = true;
}