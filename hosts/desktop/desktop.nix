{ pkgs, ... }:

{
  networking.hostName = "desktop";

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
  };

  hardware.graphics.enable = true;

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;

  # ALC 897: force analog profile so volume keys work
  services.pipewire.wireplumber.extraConfig."10-alc897-analog" = {
    "monitor.alsa.rules" = [{
      matches = [{ "device.name" = "alsa_card.pci-0000_00_1f.3"; }];
      actions.update-props = {
        "device.profile" = "output:analog-stereo+input:analog-stereo";
      };
    }];
  };

  # uinput + capabilities (needed for espanso-wayland)
  hardware.uinput.enable = true;
  security.wrappers.espanso = {
    source = "${pkgs.espanso-wayland}/bin/espanso";
    capabilities = "cap_dac_override+p";
    owner = "root";
    group = "root";
  };


  # Storage drive (nvme1n1)
  fileSystems."/mnt/storage" = {
    device = "/dev/disk/by-label/storage";
    fsType = "btrfs";
    options = [ "compress=zstd" "noatime" ];
  };
}
