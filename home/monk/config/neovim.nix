
{
  config,
  lib,
  pkgs,
  ...
}:
let
  shellAliases = {
    v = "nvim";
    vdiff = "nvim -d";
  };
in
{
  home.activation.installNvim = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.rsync}/bin/rsync -avz --chmod=D2755,F744 ${../dotfiles/nvim}/ ${config.xdg.configHome}/nvim/
  '';

  home.shellAliases = shellAliases;
  #programs.nushell.shellAliases = shellAliases;

  programs = {
    neovim = {
      enable = true;
      package = pkgs.neovim-unwrapped;

      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}
