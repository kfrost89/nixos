{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "power-menu" ''
      choice=$(printf "Lock\nSuspend\nReboot\nShutdown" | ${pkgs.fuzzel}/bin/fuzzel --dmenu --prompt "Power > ")
      case "$choice" in
        Lock) ${pkgs.swaylock}/bin/swaylock -f ;;
        Suspend) ${pkgs.swaylock}/bin/swaylock -f & sleep 0.5 && ${pkgs.systemd}/bin/systemctl suspend ;;
        Reboot) ${pkgs.systemd}/bin/systemctl reboot ;;
        Shutdown) ${pkgs.systemd}/bin/systemctl poweroff ;;
      esac
    '')
  ];
}
