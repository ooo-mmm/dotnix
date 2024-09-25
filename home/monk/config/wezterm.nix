{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    wezterm
  ];

  home.file = {
    "../dotfiles/wezterm/wezterm.lua".source = ./wezterm.lua;
  };
}
