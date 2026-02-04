let
    pkgs = import <nixpkgs> {};
    themeName = "Reversal";
in

stdenv.mkDerivation {
    pname = "gtk-icon-theme";
    # https://github.com/yeyushengfan258/Reversal-icon-theme.git
    src = builtins.fetchGit {
        url = "https://github.com/yeyushengfan258/Reversal-icon-theme.git"
    };

    buildPhase =  ''
        bash ./install.sh
    '';
    installPhase = ''
        mkdir -p $out/share/icons
        cp -r ./dist/. $out/share/icons/${themeName}
    '';
}
