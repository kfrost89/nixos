{
  programs.waybar = {
    enable = true;
    systemd.enable = false;

    settings = [{
      layer = "top";
      position = "top";
      height = 32;
      margin-top = 6;
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
        format-charging = "CHG {capacity}%";
        states = {
          warning = 20;
          critical = 10;
        };
      };

      network = {
        format-wifi = "W {essid}";
        format-ethernet = "E {ifname}";
        format-disconnected = "offline";
      };

      wireplumber = {
        format = "VOL {volume}%";
        format-muted = "MUTE";
        on-click = "pavucontrol";
      };
    }];

    style = ''
      * {
        font-family: "Hack Nerd Font";
        font-size: 12px;
        border: none;
        border-radius: 0;
        min-height: 0;
        margin: 0;
        padding: 0;
      }

      window#waybar {
        background: rgba(20, 20, 20, 0.9);
        border-radius: 16px;
        color: #b0b0b0;
      }

      tooltip {
        background: #1a1a1a;
        border: 1px solid #333333;
        border-radius: 8px;
        color: #b0b0b0;
      }

      #workspaces {
        margin: 0 4px;
      }

      #workspaces button {
        padding: 2px 8px;
        color: #555555;
        background: transparent;
      }

      #workspaces button.active {
        color: #ffffff;
      }

      #clock {
        padding: 0 12px;
        color: #e0e0e0;
      }

      #battery,
      #network,
      #wireplumber {
        padding: 0 10px;
        color: #888888;
      }

      #battery.charging {
        color: #b0b0b0;
      }

      #battery.warning:not(.charging) {
        color: #cccccc;
      }

      #battery.critical:not(.charging) {
        color: #ffffff;
      }
    '';
  };
}
