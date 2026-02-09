{ config, pkgs, ... }:

{
    # Dolphin package

    environment.systemPackages = with pkgs; [
       # Dolphin File Manager

        kdePackages.dolphin # This is the actual dolphin package
        kdePackages.dolphin-plugins # for extra dolphin features like archive handling, trash support, etc. 
        kdePackages.kio-gdrive # to access Google Drive filesystems
        kdePackages.kio # needed since 25.11
        kdePackages.kio-fuse #to mount remote filesystems via FUSE
        kdePackages.kio-extras #extra protocols support (sftp, fish and more)
        kdePackages.qtsvg
    ];
}