
{
  description = "Kenzo's personal flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hm = { 
          url =   "github:nix-community/home-manager";
          inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
    anyrun.url = "github:Kirottu/anyrun";
    ags.url = "github:ozwaldorf/ags";
    nur.url = "github:nix-community/NUR";
    spicetify-nix.url = "github:the-argus/spicetify-nix";
    nixvim.url = "github:elythh/nixvim";
  };


 outputs = { self, nixpkgs,  hm, ... }@inputs: {
    nixosConfigurations = {
      kenzo = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	specialArgs = { inherit inputs; };
        modules = [
          ./nixos/configuration.nix
        ];
      };
    };
    homeConfigurations = {
      kenzo = hm.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config = { allowUnfree = true; };
        };
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./home/home.nix ];
      };
    };
      kenzo = self.nixosConfigurations.kenzo.config.system.build.toplevel;
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
 };
}
