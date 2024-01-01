{ pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = false;
    };
    kernelParams = [ "splash" ];
    kernel.sysctl = { "vm.swappiness" = 0; };
    plymouth.enable = false;
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  environment = {
    systemPackages = with pkgs; [

      libsForQt5.qt5.qtquickcontrols2
      libsForQt5.qt5.qtgraphicaleffects

      lxqt.lxqt-policykit

      gnome.gnome-system-monitor

      betterbird
      birdtray

      vscode-fhs
      audacity

      vim
      krita

      wayland
      unrar
      swayosd
      brightnessctl
      xfce.thunar

      git
      xfce.tumbler

      inotify-tools
      eww-wayland
      swww
      fx
      stockfish
      waybar
      font-manager
      btop
      cava
      dunst
      obs-studio

      udisks
      psmisc
      udiskie
      libnotify

      pulseaudio
      glava
      easyeffects
      vlc
      pavucontrol
      ncpamixer
      gammastep

      bemenu

      neovim
      mpd
      mpv
      wl-clipboard
      slurp
      llama
      tmux
      playerctl
      pamix
      cool-retro-term
      fish
      starship
      gnutar

      wofi
      sddm
      ranger
      lf
      pistol
      tree
      spotify
      tree-sitter
      alacritty
      terminal-colors
      terminal-typeracer

      cliphist
      unzip
      gtk3
      jq
      wirelesstools

      rofi

      #programming
      typescript
      yarn
      nodejs

      go
      gcc
      clang
      zig
      zls
      rustc
      rustup
      rust-analyzer
      stylua
      ocaml
      ocaml-top
      dotnet-sdk_7

      nix-doc
      nix-output-monitor
      nix-ld
      nix-du
      nix-web
      nix-top
      nix-update
      nix-melt
      nix-tour
      nix-unit
      nix-health
      nix-deploy

      nix-tree

    ];
    variables.EDITOR = "nvim";
  };

  /* systemd.user.services.polkit-gnome-authentication-agent-1 = {
       description = "polkit-gnome-authentication-agent-1";
       wantedBy = [ "graphical-session.target" ];
       serviceConfig = {
         Type = "simple";
         ExecStart =
           "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
         Restart = "on-failure";
         RestartSec = 1;
         TimeoutStopSec = 10;
       };
     };
  */

  environment.sessionVariables = {
    NIXOS_XDG_OPEN_USE_PORTAL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    DOTNET_ROOT = "${pkgs.dotnet-sdk_7}";
  };

  nix = {
    settings.trusted-users = [ "root" "kenzo" ];
    package = pkgs.nixFlakes;
    settings = {
      max-jobs = 4;
      cores = 4;
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      keep-outputs = true;
      keep-derivations = true;
      warn-dirty = false;
    };

    gc = {
      automatic = true;
      options = "--delete-older-than 4d";
    };
    optimise.automatic = true;
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];
    };
  };

  programs = {
    fzf.keybindings = true;
    fzf.fuzzyCompletion = true;

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

  networking = {
    networkmanager.enable = true;
    hostName = "kenzo";
    useDHCP = false;
  };

  time = {
    hardwareClockInLocalTime = true;
    timeZone = "Asia/Kathmandu";
  };
  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    flatpak.enable = true;
    fstrim.enable = true;
    gvfs.enable = true;
    dbus.enable = true;
    udisks2.enable = true;
    tlp.enable = true;
    upower.enable = true;
    power-profiles-daemon.enable = false;
    journald.extraConfig = "MaxRetentionSec=1week";
    xserver = {
      dpi = 106;
      enable = true;
      videoDrivers = [ "intel" ];
      layout = "us";
      libinput = {
        enable = true;
        touchpad = {
          tapping = true;
          middleEmulation = true;
          naturalScrolling = true;
        };
      };
      displayManager.defaultSession = "hyprland";
      displayManager.sddm.enable = true;
      displayManager.sddm.theme =
        "${import ../home-manager/conf/ui/sddm.nix { inherit pkgs; }}";
      desktopManager.gnome.enable = false;
    };
    openssh = {
      enable = true;
      ports = [ 4000 ];
      settings.PasswordAuthentication = false;
      banner = "/etc/ssh-banner";
      settings = { PermitRootLogin = "yes"; };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  hardware = { opengl.enable = true; };

  # powerManagement = { cpuFreqGovernor = "performance"; };

  users = {
    users.kenzo = {
      isNormalUser = true;
      home = "/home/kenzo";
      shell = pkgs.fish;
      description = "nixOs";
      extraGroups = [ "networkmanager" "wheel" "audio" "video" ];
    };
  };

  nixpkgs = {
    overlays = [
      (self: super: {
        waybar = super.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        });
      })
    ];
    config.permittedInsecurePackages = [
      "unrar"
      "electron-12.2.3"
      "openssl-1.1.1v"
      "python-2.7.18.6"
      "figma-linux-0.10.0"
      "nodejs-14.21.3"
      "spotify"
      "discord"
      "openssl-1.1.1w"

    ];
    config.allowUnfree = true;
    config.input-fonts.acceptLicense = true;
  };

  fonts = {
    packages = with pkgs; [
      corefonts
      inconsolata

      source-code-pro
      dosis
      material-symbols
      rubik
      work-sans
      nerdfonts
    ];
  };

  sound.enable = true;
  # hardware.pulseaudio.extraConfig = "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1";

  security = {
    rtkit.enable = true;
    # polkit.enable = false;
    # polkit.debug = true;
    # polkit.extraConfig = ''
    #     polkit.addRule(function(action, subject) {
    #     // Make sure to set { security.polkit.debug = true; } in configuration.nix
    #     polkit.log("user " +  subject.user + " is attempting action " + action.id + " from PID " + subject.pid);
    #   });
    #
    #   /* Allow any local user to do anything (dangerous!). */
    #   polkit.addRule(function(action, subject) {
    #     if (subject.local) return "yes";
    # '';
  };

  programs.dconf.enable = true;
  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };

  documentation.nixos.enable = true;

  system.stateVersion = "23.05";

}

