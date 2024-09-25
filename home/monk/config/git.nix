{
  config,
  lib,
  pkgs,
  ...
}: {
  # `programs.git` will generate the config file: ~/.config/git/config
  # to make git use this config file, `~/.gitconfig` should not exist!
  #
  #    https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
  home.activation.removeExistingGitconfig = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
    rm -f ${config.home.homeDirectory}/.gitconfig
  '';

  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = "${config.home.username}";
    userEmail = "vaibhav7garg@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;

      # replace https with ssh
      url = {
        "ssh://git@github.com/ooo-mmm" = {
          insteadOf = "https://github.com/ooo-mmm";
        };
        "ssh://git@gitlab.com/" = {
          insteadOf = "https://gitlab.com/";
        };
      };
      safe.directory = "*";
    };
  };
}
