{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      # vscodevim.vim
      yzhang.markdown-all-in-one
      zxh404.vscode-proto3
      rust-lang.rust-analyzer
      usernamehw.errorlens
      esbenp.prettier-vscode
      ms-toolsai.jupyter
      bbenoist.nix
      # vspacecode.whichkey
      brettm12345.nixfmt-vscode
      eamodio.gitlens
      # github.copilot
      # ms-azuretools.vscode-docker
      ms-python.python
      ms-python.black-formatter
      foxundermoon.shell-format
      tamasfe.even-better-toml
      mhutchie.git-graph
      zainchen.json
      mkhl.direnv
      # ms-dotnettools.csdevkit
      # scala-lang.scala
      # scalameta.metals
      # vscjava.vscode-gradle
      hediet.vscode-drawio
    ];

    userSettings = {
      "editor.fontFamily" = "FiraCode Nerd Font Mono";
      "editor.formatOnSave" = true;
      "files.associations" = {
        "*.ejson" = "json";
      };
      "files.insertFinalNewline" = true;
      "files.trimTrailingWhitespace" = true;
      "files.watcherExclude" = {
        # "**/.bloop" = true;
        # "**/.metals" = true;
        # "**/.ammonite" = true;
      };
      # "github.copilot.editor.enableAutoCompletions" = true;
      # "github.copilot.enable" = {
      #   "*" = true;
      #   "plaintext" = false;
      # };
      "gitlens.launchpad.indicator.enabled" = false;
      "gitlens.statusBar.enabled" = false;
      "gitlens.telemetry.enabled" = false;
      # "metals.enableIndentOnPaste" = true;
      "telemetry.telemetryLevel" = "off";
      "workbench.startupEditor" = "none";
      "workbench.colorTheme" = "Dracula Theme";
      "window.menuBarVisibility" = "toggle";
      "extensions.ignoreRecommendations" = true;
      # "vim.normalModeKeyBindingsNonRecursive" = [{
      #   "before" = [ "<space>" ];
      #   "commands" = [ "whichkey.show" ];
      # }];
      # "vim.visualModeKeyBindingsNonRecursive" = [{
      #   "before" = [ "<space>" ];
      #   "commands" = [ "whichkey.show" ];
      # }];
      "[python]" = {
        "editor.defaultFormatter" = "ms-python.black-formatter";
      };
      "editor.minimap.enabled" = false;
    };

    mutableExtensionsDir = true;
  };
}
