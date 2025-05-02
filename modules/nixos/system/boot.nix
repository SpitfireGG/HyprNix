{ pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "nomst"
      "i8042.nopnp"
    ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = false;
    };
  };
}
