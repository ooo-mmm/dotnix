{ ... }: {
  imports =
    [ ../os.nix ../docker.nix ./montiors.nix ./hardware-configuration.nix ];
  networking.interfaces.enp6s0.wakeOnLan.enable = true;
}
