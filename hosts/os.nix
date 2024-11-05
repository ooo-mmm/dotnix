# Main default config

{ config, pkgs, host, options, lib, inputs, ... }:
let

  inherit (import ./variables.nix) username keyboardLayout;
  python-packages = pkgs.python3.withPackages (ps:
    with ps; [
      requests
      pyquery # needed for hyprland-dots Weather script
    ]);

in {

  imports = [ ./user.nix ./hyprland.nix ./nvidia.nix ];
  # BOOT related stuff
  boot = {
    kernelPackages = pkgs.linuxPackages_zen; # Kernel

    kernelParams =
      [ "systemd.mask=systemd-vconsole-setup.service" "nowatchdog" ];

    # This is for OBS Virtual Cam Support
    # kernelModules = [ "v4l2loopback" ];
    # extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];

    ## BOOT LOADERS: NOT USE ONLY 1. either systemd or grub
    # Bootloader SystemD
    loader.systemd-boot = {
      enable = true;
      # we use Git for version control, so we don't need to keep too many generations.
      configurationLimit = lib.mkDefault 10;
      # pick the highest resolution for systemd-boot's console.
      consoleMode = lib.mkDefault "max";
    };
    loader.efi = {
      #efiSysMountPoint = "/efi"; #this is if you have separate /efi partition
      canTouchEfiVariables = true;
    };

    loader.timeout = 1;

    # Bootloader GRUB
    #loader.grub = {
    #enable = true;
    #  devices = [ "nodev" ];
    #  efiSupport = true;
    #  gfxmodeBios = "auto";
    #  memtest86.enable = true;
    #  extraGrubInstallArgs = [ "--bootloader-id=${host}" ];
    #  configurationName = "${host}";
    #	 };

    # Bootloader GRUB theme, configure below

    ## -end of BOOTLOADERS----- ##

    # Make /tmp a tmpfs
    tmp = {
      useTmpfs = false;
      tmpfsSize = "30%";
    };

    # Appimage Support
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = "\\xff\\xff\\xff\\xff\\x00\\x00\\x00\\x00\\xff\\xff\\xff";
      magicOrExtension = "\\x7fELF....AI\\x02";
    };

    plymouth.enable = true;
  };

  # GRUB Bootloader theme. Of course you need to enable GRUB above.. duh!
  #distro-grub-themes = {
  #  enable = true;
  #  theme = "nixos";
  #};

  # networking
  networking.networkmanager.enable = true;
  networking.hostName = "${host}";

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = (with pkgs; [
    # System Packages
    baobab
    btrfs-progs
    clang
    curl
    cpufrequtils
    duf
    ffmpeg
    glib # for gsettings to work
    gsettings-qt
    git
    killall
    libappindicator
    libnotify
    openssl # required by Rainbow borders
    pciutils
    wget
    xdg-user-dirs
    xdg-utils
    ventoy
    (mpv.override { scripts = [ mpvScripts.mpris ]; }) # with tray
    brave
    home-manager
  ]) ++ [ python-packages ];

  # FONTS
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      fira-code
      noto-fonts-cjk-sans
      jetbrains-mono
      font-awesome
      terminus_font
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };

  # Extra Portal Configuration
  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    configPackages = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal ];
  };

  # Services to start
  services = {
    xserver = {
      enable = false;
      xkb = {
        layout = "${keyboardLayout}";
        variant = "";
      };
    };

    greetd = {
      enable = true;
      vt = 3;
      settings = {
        default_session = {
          user = username;
          command =
            "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland"; # start Hyprland with a TUI login manager
        };
      };
    };

    smartd = {
      enable = false;
      autodetect = true;
    };

    gvfs.enable = true;
    tumbler.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    udev.enable = true;
    envfs.enable = true;
    dbus.enable = true;

    fstrim = {
      enable = true;
      interval = "weekly";
    };

    libinput.enable = true;

    rpcbind.enable = false;
    nfs.server.enable = false;

    flatpak.enable = false;

    blueman.enable = true;

    power-profiles-daemon = { enable = true; };

    fwupd.enable = true;

    upower.enable = true;

    gnome.gnome-keyring.enable = true;

    #printing = {
    #  enable = false;
    #  drivers = [
    # pkgs.hplipWithPlugin
    #  ];
    #};

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      publish = {
        enable = true;
        domain = true;
        userServices = true;
      };

    };

    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "prohibit-password";
        PasswordAuthentication = false; # disable password login
        Port = 22;
        ListenAddress = "0.0.0.0";
      };
    };

    #ipp-usb.enable = true;

    #syncthing = {
    #  enable = false;
    #  user = "${username}";
    #  dataDir = "/home/${username}";
    #  configDir = "/home/${username}/.config/syncthing";
    #};
  };
  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.services.flatpak-repo = {
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # zram
  zramSwap = {
    enable = true;
    priority = 100;
    memoryPercent = 50;
    swapDevices = 1;
    algorithm = "zstd";
  };

  powerManagement = { enable = true; };

  #hardware.sane = {
  #  enable = true;
  #  extraBackends = [ pkgs.sane-airscan ];
  #  disabledDefaultBackends = [ "escl" ];
  #};

  # Bluetooth
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
    };
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;

  # Security / Polkit
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    })
  '';
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  # Cachix, Optimization settings and garbage collection automation
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Virtualization / Containers
  virtualisation.libvirtd.enable = false;
  virtualisation.podman = {
    enable = false;
    dockerCompat = false;
    defaultNetwork.settings.dns_enabled = false;
  };

  # OpenGL
  hardware.graphics = { enable = true; };

  console.keyMap = "${keyboardLayout}";

  # For Electron apps to use wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}

