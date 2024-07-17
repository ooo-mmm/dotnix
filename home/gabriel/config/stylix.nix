{
  pkgs,
  ...
}: {
  stylix = {
    enable = true;
    autoEnable = false;
    image = /home/gabriel/Pictures/Wallpapers/wallpaper.jpg;
    base16Scheme = {
      base00 = "010101"; # base
      base01 = "11111b"; # mantle
      base02 = "313244"; # surface0
      base03 = "45475a"; # surface1
      base04 = "585b70"; # surface2
      base05 = "cdd6f4"; # text
      base06 = "f5e0dc"; # rosewater
      base07 = "b4befe"; # lavender
      base08 = "f38ba8"; # red
      base09 = "fab387"; # peach
      base0A = "f9e2af"; # yellow
      base0B = "a6e3a1"; # green
      base0C = "94e2d5"; # teal
      base0D = "89b4fa"; # blue
      base0E = "cba6f7"; # mauve
      base0F = "f2cdcd"; # flamingo
    };

    cursor = {
      name = "catppuccin-mocha-light-cursors";
      package = pkgs.catppuccin-cursors.mochaLight;
      size = 16;
    };

    targets = {
      gtk = {
        enable = true;
        extraCss = ''
          // Remove rounded corners
          window.background { border-radius: 0; }
      '';
      };
    };
  };
}
