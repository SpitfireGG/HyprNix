{configs, inputs,  pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot = {
 kernelParams = [ "i915.force_probe=0a16" ];
 kernel.sysctl = { "vm.swappiness" = 10; };
 initrd.availableKernelModules = [ "hid_cherry" ];
 kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = false;
    };
  };

  /* zramSwap = {
    enable = true;
    algorithm = "zstd";
  }; */

  environment = {
    systemPackages = with pkgs; [


        xdg-desktop-portal-hyprland

      libsForQt5.qt5.qtquickcontrols2
      libsForQt5.qt5.qtgraphicaleffects

      lxqt.lxqt-policykit

      gnome.gnome-system-monitor

      betterbird

      vscode-fhs
      audacity

      vim

      wayland
      unrar
      swayosd
      brightnessctl
      xfce.thunar

      git
      xfce.tumbler

      inotify-tools
      swww
      fx
      stockfish
      waybar
      font-manager
      btop
      cava
      dunst

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
      fish
      starship
      gnutar

      wofi
      sddm
      ranger
      lf
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
      zig
      zls
      rustc
      rustup
      rust-analyzer
      stylua
      # ocaml
      # ocaml-top
      # dotnet-sdk_7

      #networking tools
      httpie
      darkstat
      freeradius
      dig
      dstat
      iftop
      mtr-gui
      mtr
      nethogs
      nload
      slurm-nm
      tcpdump
      atop

      bitwarden

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
    # DOTNET_ROOT = "${pkgs.dotnet-sdk_7}";
  };

  nix = {
 binaryCaches = [ "https://aseipp-nix-cache.global.ssl.fastly.net" ];
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
    # wireshark.enable = true;

    # fzf.keybindings = true;
    # fzf.fuzzyCompletion = true;

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
    fstrim.enable = true;
    gvfs.enable = true;
    dbus.enable = true;
    udisks2.enable = true;
    tlp.enable = false;
    /*
    upower.enable = true; */
    # power-profiles-daemon.enable = false;
    # journald.extraConfig = "MaxRetentionSec=1week";
    xserver = {
      dpi = 106;
      enable = true;
      videoDrivers = [ "nouveau" ];
      xkb.layout = "us";
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
      # desktopManager.gnome.enable = false;
    };
    openssh = {
      enable = false;
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


  # powerManagement = { cpuFreqGovernor = "performance"; };

  users = {
    users.kenzo = {
      isNormalUser = true;
      home = "/home/kenzo";
      shell = pkgs.fish;
      description = "nixOs";
      extraGroups = [ "networkmanager" "wheel" "audio" "video" "wireshark" ];
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
    config.pulseaudio = true;
    config.permittedInsecurePackages = [
      "unrar"
      "electron-12.2.3"
      "openssl-1.1.1v"
      "python-2.7.18.6"
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
  # hardware.pulseaudio.enable = true;
# hardware.pulseaudio.support32Bit = true;
  # hardware.pulseaudio.extraConfig = "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1";
  # hardware.pulseaudio.extraConfig = "unload-module module-suspend-on-idle";

  /* hardware = {
       bluetooth.enable = true;
       bluetooth.network = { General = { DisableSecurity = true; }; };
       bluetooth.input = { General = { IdleTimeout = 50; }; };
     };
  */


  programs.dconf.enable = true;
  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };

  documentation.nixos.enable = false;

  system.stateVersion = "23.05";

}

