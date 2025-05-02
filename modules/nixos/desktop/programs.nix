{ pkgs, ... }:
{
  programs = {
    # wireshark.enable = true;

    # fzf.keybindings = true;
    # fzf.fuzzyCompletion = true;

    dconf.enable = true;
    gnome-disks.enable = true;
    hyprland.enable = true;
    nix-ld.enable = true;
    xwayland.enable = true;
    fish.enable = true;
    thunar.plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
      thunar-dropbox-plugin
      thunar-media-tags-plugin
    ];
  };
}
