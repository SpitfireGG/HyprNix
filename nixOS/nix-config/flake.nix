{
  description = "Kenzo's personal dotfile";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/release-23.11";
    hm.url = "github:nix-community/home-manager/master";
    nix-colors.url = "github:misterio77/nix-colors";
    anyrun.url = "github:Kirottu/anyrun";
    ags.url = "github:ozwaldorf/ags";
    nur.url = "github:nix-community/NUR";
    spicetify-nix.url = "github:the-argus/spicetify-nix";
    nixvim.url = "github:elythh/nixvim";
  };


 outputs = { self, nixpkgs, nixpkgs-stable, hm, ... }@inputs: {
    nixosConfigurations = {
      kenzo = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/configuration.nix
        ];
      };
    };
    homeConfigurations = {
      kenzo = hm.lib.homeManagerConfiguration {
        pkgs = import nixpkgs-stable {
          system = "x86_64-linux";
          config = { allowUnfree = true; };
        };
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./home-manager/home.nix ];
      };
    };
      kenzo = self.nixosConfigurations.kenzo.config.system.build.toplevel;
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
 };
}
