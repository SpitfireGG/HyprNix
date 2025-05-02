{ stdenv, lib, buildGoModule, fetchFromGitHub, spotify, spicetify-cli, theme
, colorscheme, }:
let
  buildPre = if stdenv.isDarwin then ''
    mkdir -p $(pwd)/spicetify-config/Library/Application\ Support/Spotify
    mkdir -p $(pwd)/spicetify-config/.config/spicetify/
    export SPICETIFY_DIR="$(pwd)/spicetify-config/.config/spicetify"
    export SPOTIFY_CONTENTS_DIR="$(pwd)/Applications/Spotify.app/Contents/Resources"
  '' else ''
    mkdir -p "$(pwd)/spicetify-config"
    touch "$(pwd)/spicetify-config/prefs"
    export SPICETIFY_DIR="$(pwd)/spicetify-config/spicetify"
    export SPOTIFY_CONTENTS_DIR="$(pwd)/share/spotify"
  '';
  buildPost = if stdenv.isDarwin then ''
    # Create spotify wrapper for MacOS
    printf "#!/usr/bin/env bash\n$out/Applications/Spotify.app/Contents/MacOS/Spotify" > $out/bin/spotify
    chmod +x $out/bin/spotify

    cp -r Applications $out
  '' else ''
    # Patch spotify wrapper
    sed -i "s#${spotify}#$out#g" ./bin/spotify

    cp -r bin lib share $out
  '';
in stdenv.mkDerivation {
  pname = "spotify";
  inherit (spotify) version;
  src = spotify;

  buildPhase = ''
    ${buildPre}

    mkdir -p $(pwd)/spicetify-config
    touch $(pwd)/spicetify-config/prefs

    export HOME=$(pwd)/spicetify-config
    export XDG_CONFIG_HOME=$(pwd)/spicetify-config

    CFG_PATH=$(${spicetify-cli}/bin/spicetify-cli -c)
    ${spicetify-cli}/bin/spicetify-cli config 2>&1 > /dev/null || true

    sed -i "s:^spotify_path.*:spotify_path = $SPOTIFY_CONTENTS_DIR:" $CFG_PATH
    sed -i "s:^prefs_path.*:prefs_path = $(pwd)/spicetify-config/prefs:" $CFG_PATH

    mkdir -p "$SPICETIFY_DIR/Themes"
    cp -R ${theme} "$SPICETIFY_DIR/Themes/"

    ${spicetify-cli}/bin/spicetify-cli config current_theme ${
      builtins.baseNameOf theme
    }
    ${spicetify-cli}/bin/spicetify-cli config color_scheme ${colorscheme}
    cat $(${spicetify-cli}/bin/spicetify-cli -c)
    ${spicetify-cli}/bin/spicetify-cli backup apply || true
    ${spicetify-cli}/bin/spicetify-cli apply

    mkdir -p $out/bin
    ${buildPost}
  '';
}

