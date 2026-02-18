{ pkgs, ... }:

let
  theme-toggle = pkgs.writeShellScriptBin "theme-toggle" ''
    current=$(gsettings get org.gnome.desktop.interface color-scheme)

    set_dark() {
      gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
      gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
      gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
    }

    set_light() {
      gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
      gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'
      gsettings set org.gnome.desktop.interface icon-theme 'Papirus'
    }

    case "''${1:-toggle}" in
      dark)  set_dark ;;
      light) set_light ;;
      query)
        if [ "$current" = "'prefer-dark'" ]; then
          echo "dark"
        else
          echo "light"
        fi
        ;;
      toggle|*)
        if [ "$current" = "'prefer-dark'" ]; then
          set_light
        else
          set_dark
        fi
        pkill -SIGRTMIN+8 waybar
        ;;
    esac
  '';
in
{
  home.packages = [ theme-toggle ];
}
