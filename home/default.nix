{ inputs, lib, config, pkgs, ... }: {
  imports = [ ./config ];

  nixpkgs = { config = { allowUnfree = true; }; };

  home = {
    username = "v";
    homeDirectory = "/home/v";
    pointerCursor = {
      package = pkgs.google-cursor;
      name = "GoogleDot-White";
      size = 18;
    };

    sessionVariables = {
      backupFileExtension = "hm-bk";
      # Shell
      BROWSER = "qutebrowser";
      EDITOR = "nvim";
      TERMINAL = "alacritty";
      TERM = "xterm-256color";
      HISTFILE = "$XDG_DATA_HOME/history";
      HISTSIZE = 10000;
      SAVEHIST = 10000;
      PATH = "$HOME/.local/bin/:$PATH";

      # # ~/ Clean-up
      CARGO_HOME = "$XDG_DATA_HOME/cargo";
      GNUPGHOME = "$XDG_DATA_HOME/gnupg";
      LESSHISTFILE = "-";
      PASSWORD_STORE_DIR = "$XDG_DATA_HOME/pass";
    };
    activation.installDots = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ${pkgs.rsync}/bin/rsync -avz --chmod=D2755,F744 ${
        ./dotfiles/dots
      }/ ${config.xdg.configHome}/
    '';
  };

  gtk = { enable = true; };

  xdg = {
    # NOTE: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
    enable = true;

    # $XDG_CACHE_HOME: Absolute path to directory holding application caches
    cacheHome = "${config.home.homeDirectory}/.cache";

    # $XDG_CONFIG_HOME: Absolute path to directory holding application configurations
    configHome = "${config.home.homeDirectory}/.config";

    # $XDG_DATA_HOME: Absolute path to directory holding application data
    dataHome = "${config.home.homeDirectory}/.local/share";

    # $XDG_STATE_HOME: Absolute path to directory holding application states
    stateHome = "${config.home.homeDirectory}/.local/state";

    userDirs.createDirectories = true;
  };

  programs.home-manager.enable = true;
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
