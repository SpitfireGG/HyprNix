{ pkgs, ... }:
{
  packages = with pkgs; [
    inputs.nixvim.packages.${system}.default
    phinger-cursors
    gruvbox-gtk-theme
    reversal-icon-theme

    bc
    qbittorrent
    caprine-bin
    vesktop
    firefox-unwrapped
    wl-clipboard
    unrar
    sway-contrib.grimshot
    glib
    htop
    gcc
    nchat
    wget
    go
    gopls
    playerctl
    mpc-cli
    neovim
    xdg-desktop-portal
    imagemagick
    xorg.xev
    procps
    gammastep
    moreutils
    cava
    mpdris2
    pavucontrol
    feh
    xbanish
  ];

}
