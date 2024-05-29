{
  pkgs,
  ...
}: {
  imports = [
    ./awesome
    ./bat.nix
    ./eza.nix
    ./flameshot.nix
    ./git.nix
    ./picom.nix
    ./starship.nix
    ./xresources.nix
  ];
  home.packages = with pkgs; [
    _1password-gui
    atuin
    duf
    fd
    file
    fish
    gimp
    gnome.gnome-themes-extra
    gnumake
    jq
    neovim
    nixd
    obsidian
    pavucontrol
    qutebrowser
    ripgrep
    sxiv
    tldr
    unzip
    virtiofsd
    wezterm
    wget
    xsel
    xwallpaper
  ];
}
