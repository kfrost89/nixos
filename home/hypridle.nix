{ pkgs, ... }:

{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "hyprlock";
        before_sleep_cmd = "hyprlock";
      };
      listener = [
        { timeout = 300; on-timeout = "hyprlock"; }
        { timeout = 600; on-timeout = "${pkgs.niri}/bin/niri msg action power-off-monitors"; on-resume = "${pkgs.niri}/bin/niri msg action power-on-monitors"; }
        { timeout = 1200; on-timeout = "${pkgs.systemd}/bin/systemctl suspend"; }
      ];
    };
  };
}
