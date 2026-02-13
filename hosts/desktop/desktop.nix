{ pkgs, ... }:

{
  networking.hostName = "desktop";

  boot.kernelParams = [ "nvidia-drm.fbdev=1" ];

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    powerManagement.enable = true;
  };

  hardware.graphics.enable = true;

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;

  # Default audio to NVIDIA HDMI (monitor speakers)
  services.pipewire.wireplumber.extraConfig."10-default-hdmi" = {
    "monitor.alsa.rules" = [{
      matches = [{ "node.name" = "~alsa_output.pci-0000_01_00.1.*"; }];
      actions.update-props = {
        "node.description" = "Monitor HDMI";
        "priority.session" = 2000;
        "priority.driver" = 2000;
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
