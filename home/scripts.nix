{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "power-menu" ''
      choice=$(printf "Lock\nSuspend\nReboot\nShutdown" | ${pkgs.fuzzel}/bin/fuzzel --dmenu --prompt "Power > ")
      case "$choice" in
        Lock) ${pkgs.hyprlock}/bin/hyprlock ;;
        Suspend) ${pkgs.hyprlock}/bin/hyprlock & sleep 0.5 && ${pkgs.systemd}/bin/systemctl suspend ;;
        Reboot) ${pkgs.systemd}/bin/systemctl reboot ;;
        Shutdown) ${pkgs.systemd}/bin/systemctl poweroff ;;
      esac
    '')
  ];
}
