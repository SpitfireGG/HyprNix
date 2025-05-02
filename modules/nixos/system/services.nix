{ pkgs, ... }:
{
  services = {

    displayManager = {
      defaultSession = "hyprland";
      sddm.enable = true;
      sddm.theme = "${import ../home/conf/sddm.nix { inherit pkgs; }}";
    };
    blueman.enable = true;
    libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        middleEmulation = true;
        naturalScrolling = true;
      };
    };
    gnome.gnome-keyring.enable = true;
    gnome.tinysparql.enable = true;
    gnome.localsearch.enable = true;
    fstrim.enable = true;
    gvfs.enable = true;
    dbus.enable = true;
    udisks2.enable = true;
    tlp.enable = false;
    # upower.enable = true;
    # power-profiles-daemon.enable = false;
    # journald.extraConfig = "MaxRetentionSec=1week";
    xserver = {
      dpi = 106;
      enable = true;
      xkb.layout = "us";

    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
