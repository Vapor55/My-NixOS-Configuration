# // home.nix
{ config, pkgs, inputs, ... }:

{

  # Home Manager configuration

  home.username = "guilherme";
  home.homeDirectory = "/home/guilherme";
  home.stateVersion = "26.05"; # Or your desired NixOS release version

  # Home Manager Packages

  home.packages = with pkgs; [
    htop
    btop
    brave
    fastfetch
    onefetch
    ncdu
    sxiv
    audacious
    mpv
  ];

  # Visual Studio Code

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
    mutableExtensionsDir = true;
  };

  # Z-Shell configuration at Home Manager

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
      clean = "nh clean all";
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
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    font = {
      name = "Noto Sans";
      size = 9;
    };
  };

  # Git configuration

  programs.git = {
    enable = true;
    settings.user.name  = "Guilherme Costa de Menezes";
    settings.user.email = "guilhermecosta6777@gmail.com";
  };

  # Enable unfree Packages

  nixpkgs.config.allowUnfree = true;
}
