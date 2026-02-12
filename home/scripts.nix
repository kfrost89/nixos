{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "power-menu" ''
      choice=$(printf "Lock\nSuspend\nReboot\nShutdown" | fuzzel --dmenu --prompt "Power > ")
      case "$choice" in
        Lock) swaylock -f ;;
        Suspend) systemctl suspend ;;
        Reboot) systemctl reboot ;;
        Shutdown) systemctl poweroff ;;
      esac
    '')
  ];
}
