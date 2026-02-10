{ config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.wireless.iwd.enable = true;

  time.timeZone = "Europe/Copenhagen";
  i18n.defaultLocale = "da_DK.UTF-8";
  console.keyMap = "dk";

  # Niri
  programs.niri.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd niri-session";
        user = "greeter";
      };
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  };

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
    extraGroups = [ "wheel" ];
    initialPassword = "changeme";
  };

  # SSH — needed for nixos-anywhere, disable later if you want
  services.openssh.enable = true;

  # Packages
  environment.systemPackages = with pkgs; [
    firefox
    git
    neovim
    btop
    foot
    waybar
    fuzzel
    mako
    wl-clipboard
    impala

    # utilities
    eza
    bat
    fd
    ripgrep
    fzf
    unzip

    # file management
    nautilus
    udiskie

    # wayland / niri
    swww            # wallpaper
    swaylock        # lock screen
    swayidle        # idle management
    brightnessctl   # backlight (x270)
    playerctl       # media keys
    pavucontrol     # audio GUI
    cliphist        # clipboard history
  ];

  fonts.packages = [
    pkgs.hack-font
    pkgs.nerd-fonts.hack
  ];
  environment.variables.XCURSOR_THEME = "Adwaita";
  environment.variables.XCURSOR_SIZE = "24";

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.11";
}
