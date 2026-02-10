{ pkgs, ... }:

{
  networking.hostName = "x270";
  hardware.enableRedistributableFirmware = true;

  # Intel GPU
  hardware.graphics.enable = true;

  # Power management
  services.thermald.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
    };
  };

  # SSD
  services.fstrim.enable = true;

  # ThinkPad trackpoint
  hardware.trackpoint = {
    enable = true;
    emulateWheel = true;
  };

  # x270-only packages
  environment.systemPackages = with pkgs; [
    brightnessctl
    impala
  ];
}
