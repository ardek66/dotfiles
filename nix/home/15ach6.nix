{
  imports = [./common.nix];

  programs.lan-mouse = {
    enable = true;
    systemd = true;
    settings.authorized_fingerprints."09:43:ab:24:7f:ae:2f:ef:f2:28:4e:fe:e5:c2:d5:b0:14:c2:7a:61:17:59:22:90:4e:a6:a6:f0:32:77:69:cf" = "lain-iwakura";
  };
}
