{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "sddm-astronaut-theme";
  version = "1.3";
  dontBuild = true;
  dontWrapQtApps = true;

  buildInputs = with pkgs; [

    qt5.qtbase
    qt5.qtdeclarative

    qt5.qtquickcontrols2

    qt5.qtsvg
    qt5.qtmultimedia
  ];
  src = pkgs.fetchFromGitHub {
    owner = "Keyitdev";
    repo = "sddm-astronaut-theme";
    rev = "bf4d01732084be29cedefe9815731700da865956";
    sha256 = "JMCG7oviLqwaymfgxzBkpCiNi18BUzPGvd3AF9BYSeo=";
  };

  installPhase = ''

    mkdir -p $out/share/sddm/themes/sddm-astronaut-theme

    cp $src/Main.qml $out/share/sddm/themes/sddm-astronaut-theme/

    cp $src/metadata.desktop $out/share/sddm/themes/sddm-astronaut-theme/

    cp -r $src/Assets $out/share/sddm/themes/sddm-astronaut-theme/
    cp -r $src/Backgrounds $out/share/sddm/themes/sddm-astronaut-theme/
    cp -r $src/Components $out/share/sddm/themes/sddm-astronaut-theme/
    cp -r $src/Fonts $out/share/sddm/themes/sddm-astronaut-theme/

    cp -r $src/Themes $out/share/sddm/themes/sddm-astronaut-theme/

    # got a permissoin error fixed by this 
    chmod u+w $out/share/sddm/themes/sddm-astronaut-theme/Themes/japanese_aesthetic.conf

    #change font to systems one
    echo -e "[General]\nfontFamily=CommitMono Nerd Font" >> $out/share/sddm/themes/sddm-astronaut-theme/Themes/japanese_aesthetic.conf

  '';
  # saw meta setattr some where , just testing it out
  meta = with pkgs.lib; {
    description = "SDDM theme inspired by the Astronaut theme";
    homepage = "https://github.com/Keyitdev/sddm-astronaut-theme";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
  };

  #  got an error regarding version, (module version is needed, so tried patching it with different version, [ used the qt5 for it] , solved the version issue)
  # Patch Components/*.qml files to ensure Qt6 compatibility
  /*
    substituteInPlace $out/share/sddm/themes/sddm-astronaut-theme/Main.qml \
    --replace "import QtQuick 2.15" "import QtQuick 2.11" \
    --replace "import QtQuick.Layouts 1.15" "import QtQuick.Layouts 1.11" \
    --replace "import QtQuick.Controls 2.15" "import QtQuick.Controls 2.4" \
    --replace "import QtMultimedia" "import QtMultimedia"
    done
  */
}
