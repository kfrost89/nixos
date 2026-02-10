{ config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "desktop";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Copenhagen";
  i18n.defaultLocale = "en_DK.UTF-8";
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

  # NVIDIA — remove this block if no NVIDIA
  #services.xserver.videoDrivers = [ "nvidia" ];
  #hardware.nvidia = {
  #  modesetting.enable = true;
  #  open = false;
  #  nvidiaSettings = true;
  #};

  # Sound
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Fish
  programs.fish.enable = true;

  # User
  users.users.kristian = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" ];
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
    #brightnessctl
    #playerctl
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.11";
}
