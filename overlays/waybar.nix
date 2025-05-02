{ inputs, ... }:
{

  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
    (final: prev: {
      neovim = inputs.nixvim.packages.${prev.system}.default;
    })
  ];
}
