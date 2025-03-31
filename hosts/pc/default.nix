{ ... }: {
  imports =
    [ ../os.nix ../podman.nix ./montiors.nix ./hardware-configuration.nix ];
  networking.interfaces.enp6s0.wakeOnLan.enable = true;

  networking.firewall = {
    allowedTCPPorts = [ 21 ];
    allowedTCPPortRanges = [{
      from = 7000;
      to = 7100;
    }];
  };
}
