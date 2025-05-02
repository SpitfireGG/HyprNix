{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      xdg-desktop-portal-hyprland
      libsForQt5.qt5ct
      libsForQt5.qt5.qtquickcontrols2
      libsForQt5.qt5.qtgraphicaleffects

      libsForQt5.qt5.qtvirtualkeyboard

      clang-manpages
      tldr

      #for reverse engineering

      ida-free

      bat

      lxqt.lxqt-policykit

      gnome-system-monitor
      gnome-extension-manager

      vim

      wayland
      unrar
      brightnessctl
      xfce.thunar

      kdePackages.sddm

      git
      xfce.tumbler

      inotify-tools
      swww
      waybar
      font-manager
      btop
      cava
      dunst
      man-pages

      udisks
      psmisc
      udiskie
      libnotify
      ghostty

      pulseaudio
      vlc
      gammastep

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

      ranger
      lf
      tree
      spotify
      tree-sitter
      alacritty

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
      iftop
      mtr-gui
      mtr
      nethogs
      nload
      slurm-nm
      tcpdump
      atop

      bitwarden

      # cisco packet tracer
      (ciscoPacketTracer8.override {
        packetTracerSource = ../ciscoPacketTracer/CiscoPacketTracer822_amd64_signed.deb;
      })

    ];
    variables.EDITOR = "nvim";
  };
}
