

{ pkgs,

}:

let image = /home/kenzo/Desktop/wp5128383-ps4-anime-wallpapers.jpg;
in pkgs.stdenv.mkDerivation {
  name = "sugar-sddm-theme";
  version = "1.2";
  dontBuild = true;
  src = pkgs.fetchFromGitHub {
    owner = "MarianArlt";
    repo = "sddm-sugar-dark";
    rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
    sha256 = "0153z1kylbhc9d12nxy9vpn0spxgrhgy36wy37pk6ysq7akaqlvy";
  };

  installPhase = ''
    mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/sddm-sugar-dark
          mkdir -p $out
    cp -R ./* $out/
    cd $out/
    rm Background.jpg
    cp -r ${image} $out/Background.jpg
  '';
}
