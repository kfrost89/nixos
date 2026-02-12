{ config, pkgs, unstable, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.wireless.iwd.enable = true;

  time.timeZone = "Europe/Copenhagen";
  i18n.defaultLocale = "da_DK.UTF-8";
  console.keyMap = "dk";

  # Niri
  programs.niri.enable = true;
  programs.xwayland.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd niri-session";
        user = "greeter";
      };
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
    ];
    config.niri = {
      "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
    };
  };

  # Polkit authentication agent
  security.polkit.enable = true;
  security.pam.services.swaylock = {};

  # Keyring
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  # Sound
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  programs.fish.enable = true;
  programs.command-not-found.enable = false;

  # User
  users.users.frozt = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "input" "uinput" ];
    initialPassword = "changeme";
  };

  # SSH — needed for nixos-anywhere, disable later if you want
  services.openssh.enable = true;

  # Nautilus integration
  services.gvfs.enable = true;

  # Packages
  environment.systemPackages = with pkgs; [
    firefox
    chromium
    obsidian
    signal-desktop
    zed-editor
    git
    neovim
    btop
    foot
    waybar
    fuzzel
    mako
    wl-clipboard

    # screen sharing / presentations
    wl-mirror         # mirror output to window
    wdisplays         # GUI display config

    # utilities
    fastfetch
    eza
    bat
    fd
    ripgrep
    fzf
    unzip

    # file management
    nautilus
    sushi           # file previewer for nautilus (spacebar)
    udiskie

    # media
    zathura         # PDF viewer
    imv             # image viewer
    mpv             # media player

    # wayland / niri
    polkit_gnome    # authentication popups
    swaylock        # lock screen
    swayidle        # idle management
    playerctl       # media keys
    pavucontrol     # audio GUI
    cliphist        # clipboard history

    # dev
    nodejs
    nodePackages.prettier
    lazygit

    # text expander
    espanso-wayland

    # bluetooth
    bluetui

    # tools
    unstable.claude-code
    restic
    solaar
    tailscale
  ];

  fonts.packages = [
    pkgs.hack-font
    pkgs.nerd-fonts.hack
    pkgs.inter
  ];

  fonts.fontconfig = {
    enable = true;
    antialias = true;
    hinting = {
      enable = true;
      style = "full";
    };
    subpixel.rgba = "rgb";
    defaultFonts = {
      sansSerif = [ "Inter" ];
      monospace = [ "Hack Nerd Font" "Hack" ];
      serif = [ "Inter" ];
    };
  };
  environment.variables.XCURSOR_THEME = "Adwaita";
  environment.variables.XCURSOR_SIZE = "24";

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
  };

  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
  };

  services.snapper = {
    snapshotInterval = "hourly";
    cleanupInterval = "1d";
    configs.home = {
      SUBVOLUME = "/home";
      ALLOW_USERS = [ "frozt" ];
      TIMELINE_CREATE = true;
      TIMELINE_CLEANUP = true;
      TIMELINE_LIMIT_HOURLY = "5";
      TIMELINE_LIMIT_DAILY = "7";
      TIMELINE_LIMIT_WEEKLY = "4";
      TIMELINE_LIMIT_MONTHLY = "6";
    };
  };

  # uinput + capabilities (needed for espanso-wayland)
  hardware.uinput.enable = true;
  security.wrappers.espanso = {
    source = "${pkgs.espanso-wayland}/bin/espanso";
    capabilities = "cap_dac_override+p";
    owner = "root";
    group = "root";
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  hardware.logitech.wireless.enable = true;

  # Tailscale
  services.tailscale.enable = true;

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  nix.settings.auto-optimise-store = true;

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.11";
}
