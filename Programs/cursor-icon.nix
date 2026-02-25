( config, pkgs, ... ):

(
  # Miku cursor icon theme    

  home.pointerCursor = 
    let 
      getFrom = url: hash: name: {
          gtk.enable = true;
          x11.enable = true;
          name = Miku Cursor;
          size = 36;
          package = 
            pkgs.runCommand "moveUp" {} ''
              mkdir -p $out/share/icons
              ln -s ${pkgs.fetchzip {
                url = url;
                hash = hash;
              }} $out/share/icons/${name}
          '';
        };
    in
      getFrom 
        "https://github.com/supermariofps/hatsune-miku-windows-linux-cursors/releases/download/1.2.6/miku-cursor-linux.tar.xz"
        "sha256-12963wzw474ygy6aj32x4jcwh4344w7l2dalqddmfdw9jb1yw4va="
        "Miku-Cursor";
)