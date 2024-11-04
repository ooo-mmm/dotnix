{ ... }: {
  imports = [
    ../os.nix
    ../virtualisation.nix
    ./montiors.nix
    ./hardware-configuration.nix
  ];
}
