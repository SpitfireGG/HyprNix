{ inputs, config, pkgs, ... }:

{
  imports = [
    # inputs.ags.homeManagerModules.default
    (import (./conf/music/mpd/default.nix) { inherit config pkgs; })
    (import (./conf/music/ncmp/default.nix) { inherit config pkgs; })

  ];
  home = {
    username = "kenzo";
    homeDirectory = "/home/kenzo";
    stateVersion = "23.11";
    packages = with pkgs; [
      bc
      qbittorrent
      caprine-bin
      vesktop
      firefox
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
      killall
      moreutils
      cava
      mpdris2
      socat
      pavucontrol
      feh
    ];
  };
  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      userName = "SpitfireGG";
      userEmail = "raambasnet02@gmail.com";
    };

    /* ags = {
         enable = true;
         configDir = ./conf/ags;
         extraPackages = [ pkgs.libsoup_3 ];
       };
    */

  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.gruvbox-gtk-theme;
      name = "Gruvbox";
    };
    iconTheme = {
      package = pkgs.reversal-icon-theme;
      name = "Reversal";
    };
    cursorTheme = {
      package = pkgs.phinger-cursors;
      name = "Phinger";
    };
    font = {
      name = "Sans";
      size = 11;
    };
  };
  nixpkgs.overlays = [ ];
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
    allowUnfreePredicate = _: true;
  };
}
