{ ... }: {
  imports =
    [ ../os.nix ../docker.nix ./montiors.nix ./hardware-configuration.nix ];
}
