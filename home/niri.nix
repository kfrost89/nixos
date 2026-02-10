{ pkgs, ... }:

{
  xdg.configFile."niri/config.kdl".text = ''
    spawn-at-startup "waybar"
    spawn-at-startup "swww-daemon"
    spawn-at-startup "udiskie" "--automount"
    spawn-at-startup "wl-paste" "--watch" "cliphist" "store"

    input {
      keyboard {
        xkb {
          layout "dk"
        }
      }

      touchpad {
        tap
        natural-scroll
        accel-speed 0.2
      }

      mouse {
        accel-speed 0.0
      }
    }

    prefer-no-csd

    layout {
      gaps 8
      center-focused-column "never"

      default-column-width {
        proportion 0.5
      }

      focus-ring {
        width 2
        active-color "#c0c0c0"
        inactive-color "#4a4a4a"
      }

      border {
        off
      }
    }

    screenshot-path "~/Pictures/Screenshots/%Y-%m-%d_%H-%M-%S.png"

    binds {
      // Terminal and launcher
      Mod+Return { spawn "foot"; }
      Mod+T { spawn "foot"; }
      Mod+D { spawn "fuzzel"; }

      // Session
      Mod+E { spawn "nautilus"; }
      Mod+Shift+E { quit; }
      Mod+Shift+P { power-off-monitors; }
      Mod+L { spawn "swaylock" "-f"; }

      // Windows
      Mod+Q { close-window; }
      Mod+F { maximize-column; }
      Mod+Shift+F { fullscreen-window; }
      Mod+C { center-column; }

      // Focus
      Mod+Left { focus-column-left; }
      Mod+Right { focus-column-right; }
      Mod+Up { focus-window-or-workspace-up; }
      Mod+Down { focus-window-or-workspace-down; }
      Mod+H { focus-column-left; }
      Mod+J { focus-window-or-workspace-down; }
      Mod+K { focus-window-or-workspace-up; }
      Mod+Comma { focus-column-right; }

      // Move windows
      Mod+Shift+Left { move-column-left; }
      Mod+Shift+Right { move-column-right; }
      Mod+Shift+Up { move-window-up-or-to-workspace-up; }
      Mod+Shift+Down { move-window-down-or-to-workspace-down; }
      Mod+Shift+H { move-column-left; }
      Mod+Shift+J { move-window-down-or-to-workspace-down; }
      Mod+Shift+K { move-window-up-or-to-workspace-up; }
      Mod+Shift+Comma { move-column-right; }

      // Workspaces
      Mod+1 { focus-workspace 1; }
      Mod+2 { focus-workspace 2; }
      Mod+3 { focus-workspace 3; }
      Mod+4 { focus-workspace 4; }
      Mod+5 { focus-workspace 5; }
      Mod+6 { focus-workspace 6; }
      Mod+7 { focus-workspace 7; }
      Mod+8 { focus-workspace 8; }
      Mod+9 { focus-workspace 9; }

      Mod+Shift+1 { move-column-to-workspace 1; }
      Mod+Shift+2 { move-column-to-workspace 2; }
      Mod+Shift+3 { move-column-to-workspace 3; }
      Mod+Shift+4 { move-column-to-workspace 4; }
      Mod+Shift+5 { move-column-to-workspace 5; }
      Mod+Shift+6 { move-column-to-workspace 6; }
      Mod+Shift+7 { move-column-to-workspace 7; }
      Mod+Shift+8 { move-column-to-workspace 8; }
      Mod+Shift+9 { move-column-to-workspace 9; }

      // Sizing
      Mod+Minus { set-column-width "-10%"; }
      Mod+Equal { set-column-width "+10%"; }
      Mod+Shift+Minus { set-window-height "-10%"; }
      Mod+Shift+Equal { set-window-height "+10%"; }

      // Consume / expel
      Mod+BracketLeft { consume-or-expel-window-left; }
      Mod+BracketRight { consume-or-expel-window-right; }

      // Switch column width presets
      Mod+R { switch-preset-column-width; }

      // Screenshots
      Print { screenshot; }
      Mod+Print { screenshot-window; }
      Mod+Shift+Print { screenshot-screen; }

      // Clipboard history
      Mod+V { spawn "sh" "-c" "cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"; }

      // Media keys
      XF86AudioRaiseVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"; }
      XF86AudioLowerVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"; }
      XF86AudioMute { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
      XF86AudioMicMute { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }
      XF86MonBrightnessUp { spawn "brightnessctl" "set" "5%+"; }
      XF86MonBrightnessDown { spawn "brightnessctl" "set" "5%-"; }
      XF86AudioPlay { spawn "playerctl" "play-pause"; }
      XF86AudioNext { spawn "playerctl" "next"; }
      XF86AudioPrev { spawn "playerctl" "previous"; }
    }
  '';
}
