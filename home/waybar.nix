{
  programs.waybar = {
    enable = true;
    systemd.enable = false;

    settings = [{
      layer = "top";
      position = "top";
      height = 40;
      margin-top = 16;
      margin-left = 16;
      margin-right = 16;
      spacing = 0;
      reload_style_on_change = true;

      modules-left = [ "niri/workspaces" "mpris" ];
      modules-center = [ "clock" ];
      modules-right = [ "privacy" "custom/dnd" "idle_inhibitor" "cpu" "memory" "disk" "network" "bluetooth" "wireplumber" "battery" "tray" ];

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
        on-click-right = "foot cal";
      };

      "custom/dnd" = {
        exec = "makoctl mode | grep -q do-not-disturb && echo '{\"text\":\"dnd\",\"class\":\"active\"}' || echo '{\"text\":\"\",\"class\":\"inactive\"}'";

        return-type = "json";
        interval = 2;
        on-click = "makoctl mode -t do-not-disturb";
        tooltip = false;
      };

      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "●";
          deactivated = "○";
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
        tooltip-format-wifi = "{signalStrength}%";
        on-click = "foot impala";
        on-click-right = "rfkill toggle wifi";
      };

      wireplumber = {
        format = "{volume}%";
        format-muted = "mute";
        on-click = "pavucontrol";
        on-click-middle = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.02+ -l 1.0";
        on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.02-";
      };

      privacy = {
        icon-size = 14;
        icon-spacing = 6;
        transition-duration = 250;
        modules = [
          { type = "screenshare"; tooltip = true; tooltip-icon-size = 20; }
          { type = "audio-in"; tooltip = true; tooltip-icon-size = 20; }
          { type = "audio-out"; tooltip = true; tooltip-icon-size = 20; }
        ];
      };

      bluetooth = {
        format = "bt";
        format-connected = "bt {num_connections}";
        format-disabled = "";
        tooltip-format-connected = "{device_enumerate}";
        tooltip-format-enumerate-connected = "{device_alias}";
        on-click = "foot bluetui";
      };

      battery = {
        format = "bat {capacity}%";
        format-charging = "bat +{capacity}%";
        interval = 60;
        states = {
          warning = 20;
          critical = 10;
        };
      };

      tray = {
        icon-size = 14;
        spacing = 8;
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

      #custom-dnd {
        padding: 0 10px;
        color: #e0e0e0;
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

      #bluetooth {
        padding: 0 12px;
        color: #c0c0c0;
        transition: color 0.2s ease;
      }

      #bluetooth.connected {
        color: #e0e0e0;
      }

      #bluetooth.disabled {
        color: #707070;
      }

      #tray {
        padding: 0 8px;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #privacy {
        padding: 0 10px;
      }

      #privacy-item {
        padding: 0 4px;
      }

      #privacy-item.screenshare {
        color: #32d74b;
      }

      #privacy-item.audio-in {
        color: #ff9f0a;
      }

      #privacy-item.audio-out {
        color: #ff9f0a;
      }
    '';
  };
}
