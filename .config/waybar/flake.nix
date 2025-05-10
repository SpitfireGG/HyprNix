{
  description = "Waybar configuration with SCSS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system}.default = pkgs.stdenv.mkDerivation {
        name = "waybar-config";
        src = ./.;
        nativeBuildInputs = [ pkgs.sass ];
        buildPhase = ''
          sass style.scss style.css
        '';
        installPhase = ''
          mkdir -p $out/share/waybar
          cp config.jsonc $out/share/waybar/
          cp style.css $out/share/waybar/
        '';
      };

      devShells.${system}.default = pkgs.mkShell {
        packages = [
          pkgs.sass
          pkgs.waybar
        ];
        shellHook = ''
          echo "Waybar dev shell ready! Run 'sass --watch style.scss:style.css' to compile styles."
        '';
      };
    };
}
