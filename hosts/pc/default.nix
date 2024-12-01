{ ... }: {
  imports =
    [ ../os.nix ../docker.nix ./montiors.nix ./hardware-configuration.nix ];
  networking.interfaces.enp6s0.wakeOnLan.enable = true;

  networking.firewall = { allowedTCPPorts = [ 21 ]; };

  services.vsftpd = {
    enable = true;
    anonymousUser = true;
    localUsers = true;
    writeEnable = false;
    extraConfig = ''
      pasv_min_port=56250
      pasv_max_port=56260'';
  };
  networking.firewall = {
    allowedTCPPortRanges = [{
      from = 56250;
      to = 56260;
    }];
  };
}
