{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 34;
        margin-top = 6;
        margin-left = 200;
        margin-right = 200;
        modules-left = [ "niri/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "network" "pulseaudio" "battery" ];

        "niri/workspaces" = {
          format = "{icon}";
          format-icons = {
            active = "●";
            default = "○";
          };
        };

        clock = {
          format = "{:%H:%M}";
          format-alt = "{:%a %d %b}";
          tooltip-format = "{:%Y-%m-%d | %H:%M:%S}";
        };

        battery = {
          format = "{icon} {capacity}%";
          format-icons = [ "○" "◔" "◑" "◕" "●" ];
          format-charging = "↑ {capacity}%";
          states = {
            warning = 20;
            critical = 10;
          };
        };

        network = {
          format-wifi = "● {essid}";
          format-disconnected = "○ offline";
          tooltip-format = "{ipaddr}";
        };

        pulseaudio = {
          format = "♪ {volume}%";
          format-muted = "♪ mute";
          on-click = "pavucontrol";
        };
      };
    };

    style = ''
      * {
        font-family: "JetBrains Mono";
        font-size: 12px;
        border: none;
        min-height: 0;
      }

      window#waybar {
        background-color: rgba(26, 26, 26, 0.92);
        border-radius: 20px;
        color: #c0c0c0;
      }

      #workspaces {
        margin-left: 8px;
      }

      #workspaces button {
        color: #4a4a4a;
        padding: 0 6px;
        border-radius: 20px;
        background: transparent;
      }

      #workspaces button.active {
        color: #ffffff;
      }

      #clock {
        color: #ffffff;
        font-weight: bold;
      }

      #battery, #network, #pulseaudio {
        padding: 0 12px;
        color: #909090;
      }

      #battery.warning {
        color: #c0c0c0;
      }

      #battery.critical {
        color: #ffffff;
      }

      #network.disconnected {
        color: #4a4a4a;
      }
    '';
  };
}
