# // home.nix
{ config, pkgs, ... }

{
  home.username = "guilherme";
  home.homeDirectory = "/home/guilherme";
  home.stateVersion = "25.11"; # Or your desired NixOS release version
  home.packages = with pkgs; [
    htop
    btop
    fastfetch
    feh
    audacious
    mpv
    brave
    discord
  ];

  programs.zsh = {
    enable = true;
    enableCompletions = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      lla = "ls -la";
      lal = "ls -al";
      la = "ls -a";
      update = "nh os switch && nh home switch";
    };
    history.size = 10000;

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } # Installations with additional options. For the list of options, please refer to Zplug README.
      ];
    };
  };

  programs.git = {
    enable = true;
    userName  = "Guilherme Costa de Menezes";
    userEmail = "guilhermecosta6777@gmail.com";
  };

  programs.neovim.lazyvim.enable = true;

  home-manager.users.guilherme.services.kdeconnect.enable = true;

  networking.firewall = rec {
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

  nixpkgs.config.allowUnfree = true;
}
