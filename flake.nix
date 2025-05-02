{
  description = "Kenzo's personal flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags.url = "github:ozwaldorf/ags";
    spicetify-nix.url = "github:the-argus/spicetify-nix";
    nixvim.url = "github:elythh/nixvim";
  };

  outputs =
    {
      self,
      nixpkgs,
      hm,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        kenzo = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/dell/configuration.nix
            ./modules/nixos/ciscoPacketTracer/packetTracerByp.nix
          ];
        };
      };
      homeConfigurations = {
        kenzo = hm.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config = {
              allowUnfree = true;
            };
          };
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./kenzo/home.nix ];
        };
      };
      kenzo = self.nixosConfigurations.kenzo.config.system.build.toplevel;
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
    };
}
