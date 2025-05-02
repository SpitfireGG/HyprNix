{
  description = "spicetify nix";

  inputs = {
    spicetify-themes = {
      url = "github:spicetify/spicetify-themes";
      flake = false;
    };
    spicetify-themes-alindl = {
      url = "github:alindl/spicetify-themes";
      flake = false;
    };
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, nixpkgs, spicetify-themes, spicetify-themes-alindl, flake-utils, }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          config.allowAliases = true;
        };
      in {
        formatter = pkgs.alejandra;
        packages = rec {
          solarizedDark = pkgs.callPackage ./spicetify.nix {
            theme = "${spicetify-themes-alindl}/Ziro";
            colorscheme = "solarized-dark";
          };
          dracula = pkgs.callPackage ./spicetify.nix {
            theme = "${spicetify-themes}/Sleek";
            colorscheme = "dracula";
          };
          dracula-text = pkgs.callPackage ./spicetify.nix {
            theme = "${spicetify-themes}/text";
            colorscheme = "dracula";
          };
          nord = pkgs.callPackage ./spicetify.nix {
            theme = "${spicetify-themes}/Sleek";
            colorscheme = "nord";
          };
          nord-text = pkgs.callPackage ./spicetify.nix {
            theme = "${spicetify-themes}/text";
            colorscheme = "nord";
          };
          solarized-text = pkgs.callPackage ./spicetify.nix {
            theme = "${spicetify-themes}/text";
            colorscheme = "solarized";
          };
        };
      });
}

