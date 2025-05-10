{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      alacritty-theme,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      # Define a default package
      packages.${system}.default = pkgs.hello; # Replace with your desired package

      # Define NixOS configuration
      nixosConfigurations.kenzo = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          (
            { config, pkgs, ... }:
            {
              # Install the overlay
              nixpkgs.overlays = [ alacritty-theme.overlays.default ];
            }
          )
          (
            { config, pkgs, ... }:
            {
              homeConfiguration.kenzo = hm: {
                programs.alacritty = {
                  enable = true;
                  # Use a color scheme from the overlay
                  settings.import = [ pkgs.alacritty-theme.cyber_punk_neon ];
                };
              };
            }
          )
        ];
      };
    };
}
