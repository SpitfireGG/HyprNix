{ config, pkgs }:

{
  services.mpd = {
    enable = true;
    musicDirectory = "/home/kenzo/Music/OnTheSpot/";
    dataDir = "/home/kenzo/.config/mpd";
    extraConfig = ''
      auto_update           "yes"
      restore_paused        "yes"
      audio_output {
        type "pulse"
        name "Pulseaudio"
        server "127.0.0.1" # add this line - MPD must connect to the local sound server
      }

      audio_output {
      	type                "fifo"
      	name                "Visualizer"
      	format              "44100:16:2"
      	path                "/tmp/mpd.fifo"
      }
      audio_output {
      	type		            "httpd"
      	name		            "lossless"
      	encoder		          "flac"
      	port		            "8000"
      	max_client	        "8"
      	mixer_type	        "software"
      	format		          "44100:16:2"
      }
    '';
    network.startWhenNeeded = true;

  };
  imports = [ (import ./misc.nix { inherit pkgs; }) ];
}

