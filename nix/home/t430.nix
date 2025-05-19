{

  imports = [./common.nix];

  services = {
    mpd.enable = true;
    mpd.musicDirectory = "/mnt/ultrabay/slsk/music";
    mpd.extraConfig = ''
    	audio_output {
		type "pipewire"
		name "pipewire output"
	}
    '';
  };

  programs.lan-mouse = {
    enable = true;
    systemd = true;

    settings.clients = [
      {
        position = "left";
        ips = [ "10.42.0.58" ];
        port = 4242;
        hostname = "alisu-mizuki";
        activate_on_startup = true;
      }
    ];
  };
}
