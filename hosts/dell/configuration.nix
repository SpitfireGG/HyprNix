{
  ...
}:
{
  imports = [

    #hardware-configuration
    ./hardware-configuration.nix

    # cisco-packet-tracer
    ../modules/packetTracerByp.nix

    #system configurations
    ../../modules/nixos/system/boot.nix
    ../../modules/nixos/system/hardware.nix
    ../../modules/nixos/system/networking.nix
    ../../modules/nixos/system/services.nix
    ../../modules/nixos/system/nixSetting.nix
    ../../modules/nixos/system/nixpkgs.nix

    #desktop configurations
    ../../modules/nixos/desktop/user.nix
    ../../modules/nixos/desktop/fonts.nix
    ../../modules/nixos/desktop/programs.nix
    ../../modules/nixos/desktop/session.nix
    ../../modules/nixos/desktop/timezone.nix

    # programs & packages
    ../../modules/nixos/programs/default.nix

    # overlays
    ../../overlays/waybar.nix

    #miscs
    ../../modules/nixos/misc/default.nix
  ];
}
