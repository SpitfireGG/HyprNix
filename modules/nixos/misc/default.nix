{ pkgs, ... }:
{
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];
    };
  };

  security.rtkit.enable = true;

  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };

  documentation = {
    nixos.enable = true;
    enable = true;
    man.enable = true;
    dev.enable = true;
  };

  system.stateVersion = "23.05";

}
