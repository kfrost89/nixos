{ pkgs, ... }:

let
  schema = pkgs.gsettings-desktop-schemas;
  schemaDir = "${schema}/share/gsettings-schemas/${schema.name}";

  theme-toggle = pkgs.writeShellApplication {
    name = "theme-toggle";
    runtimeInputs = [ pkgs.glib ];
    text = ''
      export XDG_DATA_DIRS="${schemaDir}:''${XDG_DATA_DIRS:-}"

      gs() { gsettings "$1" org.gnome.desktop.interface "''${@:2}"; }
      current=$(gs get color-scheme)

      set_dark() {
        gs set color-scheme 'prefer-dark'
        gs set gtk-theme 'adw-gtk3-dark'
        gs set icon-theme 'Papirus-Dark'
      }

      set_light() {
        gs set color-scheme 'prefer-light'
        gs set gtk-theme 'adw-gtk3'
        gs set icon-theme 'Papirus'
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
  };
in
{
  home.packages = [ theme-toggle ];
}
