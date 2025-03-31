{ lib, pkgs, ... }: {

  virtualisation = {
    containers.enable = true;
    docker.enable = lib.mkForce false;
    podman = {
      enable = lib.mkForce true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = lib.mkForce true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = lib.mkForce true;
      # Periodically prune Podman resources
      autoPrune = {
        enable = lib.mkForce true;
        dates = "weekly";
        flags = [ "--all" ];
      };
    };

    oci-containers = { backend = "podman"; };
  };

  systemd.tmpfiles.rules = [
    # Ensure podman-store and podman-run directories exist
    "d /media/data/podman-store 0755 v users -"
    "d /media/data/podman-run 0755 v users -"
  ];

  environment.systemPackages = with pkgs; [
    dive # look into docker image layers
    podman-tui # status of containers in the terminal
    podman-compose # start group of containers for dev
  ];
}
