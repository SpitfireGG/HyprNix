{
  nixpkgs = {
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
}
