{
  lib,
  pkgs,
  ...
}: {
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs;
      [
        # java
        temurin-bin
        # openjdk21 # LTS # Match java.enable version
        # openjfx24 # even used?

        # OpenGL
        mesa
        libGL
        libGLU
        libglvnd

        # audio
        openal
        pipewire
        alsa-lib

        # input & video
        libusb1
        libudev0-shim

        # others
        zlib
        glib
        libpng
        libjpeg
        freetype
      ]
      # X11
      ++ (with pkgs.xorg; [
        libXi
        libX11
        libXtst
        libXrandr
        libXrender
        libXcursor
        libXxf86vm
        libXxf86dga
        libXinerama
        libXxf86misc
      ]);
  };
}