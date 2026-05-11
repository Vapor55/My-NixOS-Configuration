{ config, pkgs, ... }:

{
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

   ohMyZsh = {
    enable = true;
    plugins = [
      "git"
      "z"
    ];
    theme = "lambda";
   };
}
