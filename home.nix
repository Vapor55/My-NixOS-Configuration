// home.nix
{ config, pkg, ... }

{
  home.username = "guilherme";
  home.homeDirectory = "/home/guilherme";
  home.stateVersion = "25.05"; # Or your desired NixOS release version
  home.packages = with pkgs; [

  ];
  home.sessionPath = [
    "$HOME/.local/bin"
  ]; 
}
