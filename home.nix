# // home.nix
{ config, pkgs, ... }:

{
  home.username = "guilherme";
  home.homeDirectory = "/home/guilherme";
  home.stateVersion = "25.11"; # Or your desired NixOS release version
  home.packages = with pkgs; [
    htop
    btop
    neovim
    fastfetch
    feh
    audacious
    mpv
    discord
  ];

  programs.dconf.profiles.user.databases = [
    {
      settings."org/gnome/desktop/interface" = {
        gtk-theme = "Adwaita";
        icon-theme = "Flat-Remix-Red-Dark";
        font-name = "Noto Sans Medium 11";
        document-font-name = "Noto Sans Medium 11";
        monospace-font-name = "Noto Sans Mono Medium 11";
      };
    }
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

  programs.git = {
    enable = true;
    userName  = "Guilherme Costa de Menezes";
    userEmail = "guilhermecosta6777@gmail.com";
  };

  nixpkgs.config.allowUnfree = true;
}
