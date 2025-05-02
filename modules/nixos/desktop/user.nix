{ pkgs, ... }:
{
  users = {
    users.kenzo = {
      isNormalUser = true;
      home = "/home/kenzo";
      shell = pkgs.fish;
      description = "nixos";
      extraGroups = [
        "networkmanager"
        "wheel"
        "audio"
        "video"
        "wireshark"
      ];
    };
  };

}
