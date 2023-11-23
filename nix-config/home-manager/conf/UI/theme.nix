#theme.nix ------------- gruvbox-plus-icon-theme


{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "GruvboxPlus";

  src = pkgs.fetchurl {
    url = "https://github.com/SylEleuth/gruvbox-plus-icon-pack/releases/download/v4.0/gruvbox-plus-icon-pack-4.0.zip";
    sha256 = "06sqgdqw8g7k0k0d5cngbjl6mfyi0zsbvvj5dwr3fsg3yxqcvmlv";
  };
  dontUnpack = true;

  # installPhase = ''
  # mkdir -p $out
  # ${pkgs.unzip}/bin/unzip $src -d $out/
  # '';
     installPhase = ''
     mkdir -p $out/icons/Gruvbox-plus-icon
     ${pkgs.unzip}/bin/unzip $src -d $out/icons/Gruvbox-plus-icon
   '';

}


