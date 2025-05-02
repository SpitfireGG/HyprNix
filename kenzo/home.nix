{
  inputs,
  config,
  pkgs,
  lib,
  ...
}@args:

let
  username = "kenzo";
  homeDirectory = "/home/${username}";
  system = pkgs.system; # Get system from pkgs context
in
{
  imports = [
    ../modules/home-manager/programs/default.nix
    ../modules/home-manager/user/program.nix
    ../modules/home-manager/user/theming.nix
  ];

  home = {
    inherit username homeDirectory;
    stateVersion = "24.11";

    sessionVariables = {
      XCURSOR_THEME = "phinger-cursors";
      XCURSOR_SIZE = "24";
      GTK_THEME = "Gruvbox-dark";
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
      ];
    };
    overlays = [
    ];
  };

  fonts.fontconfig.enable = true;

  systemd.user.startServices = "sd-switch";
}
