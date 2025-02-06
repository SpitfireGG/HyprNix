{ inputs, config, pkgs, lib, ... } @ args:

let
  username = "kenzo";
  homeDirectory = "/home/${username}";
  system = pkgs.system; # Get system from pkgs context
in
{
  imports = [ 
  ];

  home = {
    inherit username homeDirectory;
    stateVersion = "24.11";

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

    sessionVariables = {
      XCURSOR_THEME = "phinger-cursors";
      XCURSOR_SIZE = "24";
      GTK_THEME = "Gruvbox-dark";
    };
  };

  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      userName = "SpitfireGG";
      userEmail = "raambasnet02@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = true;
      };
    };

    bash.enable = true;
    direnv.enable = true;
    fzf.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.gruvbox-gtk-theme;
      name = "Gruvbox-dark"; 
    };
    iconTheme = {
      package = pkgs.reversal-icon-theme;
      name = "Reversal-dark"; 
    };
    cursorTheme = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors";
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
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
