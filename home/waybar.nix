{
  programs.waybar = {
    enable = true;
    systemd.enable = false;

    settings = [{
      layer = "top";
      position = "top";
      height = 40;
      margin-top = 8;
      margin-left = 200;
      margin-right = 200;
      spacing = 0;
      reload_style_on_change = true;

      modules-left = [ "niri/workspaces" "mpris" ];
      modules-center = [ "clock" ];
      modules-right = [ "idle_inhibitor" "cpu" "memory" "disk" "network" "wireplumber" "battery" ];

      "niri/workspaces" = {};

      mpris = {
        format = "{title} — {artist}";
        format-paused = "{title} — {artist} (paused)";
        format-stopped = "";
        max-length = 40;
        tooltip = false;
      };

      clock = {
        format = "{:%H:%M}";
        format-alt = "w{:%V · %d %b}";
        tooltip-format = "{:%A %d %B %Y · Week %V}";
      };

      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "idle off";
          deactivated = "idle on";
        };
        tooltip-format-activated = "Idle inhibitor active";
        tooltip-format-deactivated = "Idle inhibitor inactive";
      };

      cpu = {
        format = "cpu {usage}%";
        interval = 5;
        on-click = "foot btop";
      };

      memory = {
        format = "mem {used:0.1f}G";
        interval = 5;
        on-click = "foot btop";
      };

      disk = {
        format = "disk {percentage_used}%";
        interval = 30;
        path = "/";
        on-click = "nautilus";
      };

      network = {
        format-wifi = "{essid}";
        format-ethernet = "eth";
        format-disconnected = "offline";
        on-click = "foot impala";
      };

      wireplumber = {
        format = "{volume}%";
        format-muted = "mute";
        on-click = "pavucontrol";
      };

      battery = {
        format = "bat {capacity}%";
        format-charging = "bat +{capacity}%";
        states = {
          warning = 20;
          critical = 10;
        };
      };
    }];

    style = ''
      * {
        font-family: "Hack Nerd Font", "Hack";
        font-size: 12px;
        border: none;
        border-radius: 0;
        min-height: 0;
        margin: 0;
        padding: 0;
      }

      window#waybar {
        background: rgba(0, 0, 0, 0.85);
        border-radius: 14px;
        border: none;
        color: #e0e0e0;
      }

      tooltip {
        background: rgba(0, 0, 0, 0.9);
        border: none;
        border-radius: 8px;
        color: #e0e0e0;
      }

      #workspaces {
        margin-left: 6px;
      }

      #workspaces button {
        padding: 6px 5px;
        color: #b0b0b0;
        background: transparent;
        border-radius: 10px;
        transition: all 0.2s ease;
      }

      #workspaces button.active {
        color: #ffffff;
        background: transparent;
      }

      #mpris {
        padding: 0 12px;
        color: #b0b0b0;
        font-style: italic;
      }

      #mpris.playing {
        color: #d0d0d0;
      }

      #mpris.paused {
        color: #909090;
      }

      #clock {
        padding: 0 16px;
        color: #e0e0e0;
        letter-spacing: 0.5px;
      }

      #idle_inhibitor {
        padding: 0 10px;
        color: #909090;
      }

      #idle_inhibitor.activated {
        color: #e0e0e0;
      }

      #cpu {
        padding: 0 10px;
        color: #c0c0c0;
        transition: color 0.2s ease;
      }

      #memory {
        padding: 0 10px;
        color: #c0c0c0;
        transition: color 0.2s ease;
      }

      #disk {
        padding: 0 10px;
        color: #c0c0c0;
        transition: color 0.2s ease;
      }

      #cpu:hover,
      #memory:hover,
      #disk:hover {
        color: #e0e0e0;
      }

      #network {
        padding: 0 12px;
        color: #c0c0c0;
        transition: color 0.2s ease;
      }

      #wireplumber {
        padding: 0 12px;
        color: #c0c0c0;
        transition: color 0.2s ease;
      }

      #battery {
        padding: 0 12px;
        color: #c0c0c0;
        transition: color 0.2s ease;
      }

      #battery.charging {
        color: #d0d0d0;
      }

      #battery.warning:not(.charging) {
        color: #d4a87a;
      }

      #battery.critical:not(.charging) {
        color: #d48a8a;
      }

      #network.disconnected {
        color: #707070;
      }

      #wireplumber.muted {
        color: #707070;
      }
    '';
  };
}
