# // home.nix
{ config, pkgs, inputs, ... }:

{
  home.username = "guilherme";
  home.homeDirectory = "/home/guilherme";
  home.stateVersion = "26.05"; # Or your desired NixOS release version
  home.packages = with pkgs; [
    htop
    btop
    vscode
    fastfetch
    onefetch
    feh
    audacious
    mpv
    vesktop
    discord
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      lla = "ls -la";
      lal = "ls -al";
      la = "ls -a";
      update = "nh os switch";
      update-home = "nh home switch";
    };

    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    history.ignorePatterns = ["rm *" "pkill *" "cp *"];

    initContent = ''
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';

    zplug = {
      enable = true;
      plugins = [
        {name = "zsh-users/zsh-autosuggestions";}
        {
          name = "romkatv/powerlevel10k";
          tags = [ "as:theme" "depth:1" ];
        }
      ];
    };
  };

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
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    font = {
      name = "RobotoMono Nerd Font";
      size = 11;
    };
  };

  programs.git = {
    enable = true;
    settings.user.name  = "Guilherme Costa de Menezes";
    settings.user.email = "guilhermecosta6777@gmail.com";
  };

  nixpkgs.config.allowUnfree = true;
}
