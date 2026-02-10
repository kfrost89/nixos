{
  programs.waybar = {
    enable = true;
    systemd.enable = false;

    settings = [{
      layer = "top";
      position = "top";
      height = 34;
      margin-top = 8;
      margin-left = 300;
      margin-right = 300;
      spacing = 0;
      reload_style_on_change = true;

      modules-left = [ "niri/workspaces" ];
      modules-center = [ "clock" ];
      modules-right = [ "network" "wireplumber" "battery" ];

      "niri/workspaces" = {};

      clock = {
        format = "{:%H:%M}";
        format-alt = "{:%a %d %b}";
      };

      battery = {
        format = "{capacity}%";
        format-charging = "+ {capacity}%";
        states = {
          warning = 20;
          critical = 10;
        };
      };

      network = {
        format-wifi = "{essid}";
        format-ethernet = "eth";
        format-disconnected = "offline";
      };

      wireplumber = {
        format = "{volume}%";
        format-muted = "mute";
        on-click = "pavucontrol";
      };
    }];

    style = ''
      * {
        font-family: "Hack Nerd Font", "Hack";
        font-size: 11px;
        border: none;
        border-radius: 0;
        min-height: 0;
        margin: 0;
        padding: 0;
      }

      window#waybar {
        background: #141414;
        border-radius: 14px;
        border: 1px solid #2a2a2a;
        color: #888888;
      }

      tooltip {
        background: #1a1a1a;
        border: 1px solid #2a2a2a;
        border-radius: 8px;
        color: #c0c0c0;
      }

      #workspaces {
        margin-left: 6px;
      }

      #workspaces button {
        padding: 4px 8px;
        color: #4a4a4a;
        background: transparent;
        border-radius: 10px;
        transition: all 0.2s ease;
      }

      #workspaces button.active {
        color: #e0e0e0;
        background: #2a2a2a;
      }

      #clock {
        padding: 0 14px;
        color: #c0c0c0;
        letter-spacing: 0.5px;
      }

      #battery,
      #network,
      #wireplumber {
        padding: 0 10px;
        color: #666666;
        transition: color 0.2s ease;
      }

      #battery.charging {
        color: #999999;
      }

      #battery.warning:not(.charging) {
        color: #b0b0b0;
      }

      #battery.critical:not(.charging) {
        color: #e0e0e0;
      }

      #network.disconnected {
        color: #3a3a3a;
      }

      #wireplumber.muted {
        color: #3a3a3a;
      }
    '';
  };
}
