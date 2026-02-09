{ config, pkgs, ... }:

{
  # XDG User Dirs

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
}