# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).




{ config,lib, pkgs, ... } :


{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
       /home/spitfire/programming/programming.nix
       /home/spitfire/.config/config_apps.nix
 	#     ./cpu-freq.nix

    ];

   systemd.user.services.polkit-gnome-authentication-agent-1 = {
       description = "polkit-gnome-authentication-agent-1";
       wantedBy = [ "graphical-session.target" ];
       serviceConfig = {
         Type = "simple";
         ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
         Restart = "on-failure";
         RestartSec = 1;
         TimeoutStopSec = 10;
       };
     };


  nix = {
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
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  xdg = {
  portal.enable = true;
  portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  }; 

  programs = {
  hyprland.enable = true;
  hyprland.xwayland.enable = true;
  fish.enable = true;
  };
  

  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;

  boot = {
    kernel.sysctl = { "vm.swappiness" = 10;  };
    loader.grub.enable = true;
    loader.grub.devices = ["nodev"];
    loader.grub.efiInstallAsRemovable = true;
    loader.grub.efiSupport = true;
    loader.grub.useOSProber = true;
    swraid.enable = false;
    plymouth.enable = false;
    tmp.cleanOnBoot = true;
  };
  
  #enable wireless support 
  networking = {
	networkmanager.enable = true; 
	hostName = "spitfire"; 
  	useDHCP = false;
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  # Set your time zone.
  time.timeZone = "Asia/Kathmandu";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    layout = "us";
    dpi = 96;
    xkbVariant = "";
  
    videoDrivers = [ "intel" ];
  };

services.udisks2.enable = true;
services.gvfs.enable = true;




# setup opengl
hardware = {
  opengl.enable = true;
#   extraPackages = with pkgs;[
#      intel-media-driver 
#      intel-graphics-compiler
#      intel-ocl
#      inteltool
#   ];
#   driSupport = true;
#   driSupport32Bit = true;
};

#
# setup intel GPU settings

powerManagement = {
   enable = false;
   cpuFreqGovernor = "performance";
};




  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.spitfire = {
    isNormalUser = true;
    home = "/home/spitfire";
    shell = pkgs.fish;
    description = "nixOs";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages

  # List packages installed in system profile. To search, run:
  # $ nix search wget
    # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  nixpkgs = {
    overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
    ];
      config.permittedInsecurePackages = [
	"electron-12.2.3"
	"openssl-1.1.1v"
	"python-2.7.18.6"
      ];
      config.allowUnfree = true;
   };



  environment.variables.EDITOR = "vim";

  fonts = {
  enableDefaultPackages = true;
  packages = with pkgs; [
    jetbrains-mono
    anonymousPro
    ostrich-sans
    work-sans
    profont
    fantasque-sans-mono
    noto-fonts
    noto-fonts-emoji
    font-awesome
    nerdfonts
    source-code-pro
    source-sans-pro
    ];
      fontconfig = {
      antialias = true;
      cache32Bit = true;
      hinting.enable = true;
      hinting.autohint = true;
      defaultFonts = {
        monospace = [ "Source Code Pro" ];
        sansSerif = [ "Source Sans Pro" ];
        serif = [ "Source Serif Pro" ];
      };
    };
  };
 





  sound.enable = true;
  security.rtkit.enable = true;
  security.polkit.enable = true;
  services.pipewire = {
     enable = true;
     alsa.enable = true;
     alsa.support32Bit = true;
     pulse.enable = true;
     jack.enable = true;
  };


  # Some programs need SUID wrappers, can be configured further or are
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [4000];
    settings.PasswordAuthentication = false;
    banner = "/etc/ssh-banner";
    settings = {
    PermitRootLogin = "yes";
    };
  };
			

  documentation.nixos.enable = false;

    
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
  system.autoUpgrade.enable = true;
  system.copySystemConfiguration = true;
  system.autoUpgrade.allowReboot = true; 
  system.autoUpgrade.channel = "https://channels.nixos.org/nixos-23.05";

}

