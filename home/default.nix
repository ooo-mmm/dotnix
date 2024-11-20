{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [ ./config ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "v";
    homeDirectory = "/Users/v";
    sessionVariables = {
      backupFileExtension = "hm-bk";
      # Shell
      BROWSER = "brave";
      EDITOR = "nvim";
      TERMINAL = "iterm2";
      TERM = "xterm-256color";
      HISTFILE = "$XDG_DATA_HOME/history";
      HISTSIZE = 10000;
      SAVEHIST = 10000;
      PATH = "$HOME/.local/bin/:$PATH";
    };
    activation.installDots = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ${pkgs.rsync}/bin/rsync -avz --chmod=D2755,F744 ${./dotfiles/fastfetch}/ ${config.xdg.configHome}/fastfetch/
    '';
  };

  programs.home-manager.enable = true;
  # Nicely reload system units when changing configs

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
