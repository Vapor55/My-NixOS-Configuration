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
    discord
    vscode
    git
    fastfetch
    onefetch
    ncdu
    sxiv
    gimp
    audacious
    mpv
    gamemode
    gamescope
    mangohud
    lutris
  ];

    programs.home-manager.enable = true;

    xdg.desktopEntries.nemo = {
      name = "Nemo";
      exec = "${pkgs.nemo-with-extensions}/bin/nemo";
    };
   xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = [ "nemo.desktop" ];
        "application/x-gnome-saved-search" = [ "nemo.desktop" ];
    };
  };
  dconf = {
    settings = {
      "org/cinnamon/desktop/interface" = {
        can-change-accels = true;
      };
      "org/cinnamon/desktop/applications/terminal" = {
        exec = "kitty";
        # exec-arg = ""; # argument
      };
    };
  };
  home.file = {
    ".gnome2/accels/nemo".text = ''
    (gtk_accel_path "<Actions>/DirViewActions/OpenInTerminal" "F4")
    '';
};
  services.udiskie = {
    enable = true;
    settings = {
      # workaround for
      # https://github.com/nix-community/home-manager/issues/632
      program_options = {
        # replace with your favorite file manager
        file_manager = "${pkgs.nemo-with-extensions}/bin/nemo";
      };
    };
  };

  xdg.userDirs = {
    enable = true;
    desktop = "Área de Trabalho";
    documents = "Documentos";
    download = "Downloads";
    pictures = "Imagens";
    videos = "Vídeos";
    music = "Música";
    templates = "Modelos";
    publicShare = "Público";
  };

  xdg.configFile."niri/config.kdl".source = ./config.kdl;

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
      update-full = "nh os switch && nh home switch";
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

  # Enable unfree Packages

  nixpkgs.config.allowUnfree = true;
}
