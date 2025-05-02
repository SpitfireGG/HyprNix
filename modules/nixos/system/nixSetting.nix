{ pkgs, ... }:
{
  nix = {
    settings.substituters = [ "https://aseipp-nix-cache.global.ssl.fastly.net" ];
    package = pkgs.nixVersions.stable;
    settings = {
      max-jobs = 4;
      cores = 4;
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
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
}
