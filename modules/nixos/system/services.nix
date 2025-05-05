{ pkgs, ... }:
{
  services = {
    displayManager = {
      defaultSession = "hyprland";
      sddm = {
        enable = false; 
        wayland.enable = true; 
        enableHidpi = true;
        autoNumlock = false; 
        wayland.compositorCommand = "${pkgs.hyprland}/bin/Hyprland";
        theme = "sddm-astronaut-theme";
        settings = {
          General = {
            Numlock = "none";
          };
        };
      }; 
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

  # install the custom theme
  environment.systemPackages = [
    (import ../../../kenzo/conf/ui/sddm.nix { inherit pkgs; })
  ];

  # configure sddm to use black_hole 
  environment.etc."sddm.conf.d/astronaut-theme.conf".text = ''
    [Theme]
    Current=sddm-astronaut-theme
    ThemeDir=/run/current-system/sw/share/sddm/themes/sddm-astronaut-theme/
    ConfigFile=/run/current-system/sw/share/sddm/themes/sddm-astronaut-theme/Themes/japanese_aesthetic.conf
  '';
}
