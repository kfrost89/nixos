# NixOS Configuration

## Overview

Multi-host NixOS flake configuration for a ThinkPad X270 laptop and an NVIDIA desktop. Uses Niri (scrollable tiling Wayland compositor), Home Manager for user config, and disko for declarative disk partitioning.

## Structure

```
nixos-config/
├── flake.nix                 # Flake inputs (nixpkgs 25.11, unstable, disko, home-manager)
├── flake.lock
├── configuration.nix         # Shared system config (all hosts)
├── disko-config.nix          # Disk layout: GPT + LUKS + Btrfs subvolumes
├── home.nix                  # Home Manager entry point (imports home/ modules)
├── home/
│   ├── foot.nix              # Terminal emulator (Hack font, monochrome)
│   ├── fish.nix              # Fish shell
│   ├── starship.nix          # Shell prompt (minimal monochrome)
│   ├── niri.nix              # Niri compositor config (KDL via xdg.configFile)
│   ├── waybar.nix            # Status bar (floating dynamic island style)
│   ├── mako.nix              # Notification daemon
│   ├── swaylock.nix          # Lock screen (monochrome)
│   ├── swayidle.nix          # Idle management (lock 5min, monitors off 10min)
│   └── impala.nix            # WiFi TUI for iwd
├── hosts/
│   ├── x270/
│   │   └── x270.nix          # ThinkPad X270: Intel GPU, TLP, thermald, trackpoint, WiFi firmware
│   └── desktop/
│       └── desktop.nix       # Desktop: NVIDIA proprietary, Steam, gamemode
```

## Hosts

### x270 (ThinkPad X270)
- Intel GPU with `hardware.graphics`
- Power management: TLP (performance on AC, powersave on battery) + thermald
- WiFi: iwd + impala (laptop-only packages)
- Brightness: brightnessctl (laptop-only)
- TrackPoint with scroll emulation
- fstrim for SSD
- Rebuild: `sudo nixos-rebuild switch --flake github:kfrost89/nixos#x270 --refresh`

### desktop (NVIDIA)
- NVIDIA proprietary driver (closed source, modesetting)
- Steam with gamescope session
- Gamemode enabled
- Rebuild: `sudo nixos-rebuild switch --flake github:kfrost89/nixos#desktop --refresh`

## Shared Configuration

### System
- Boot: systemd-boot + EFI
- Disk: LUKS encryption → Btrfs (subvolumes: @, @home, @nix, @log, @snapshots)
- Networking: iwd
- Audio: PipeWire (ALSA + PulseAudio compat)
- Login: greetd + tuigreet → niri-session
- Shell: Fish (system-wide) + Starship prompt
- Locale: Danish (da_DK.UTF-8, Europe/Copenhagen, dk keymap)
- SSH: enabled
- Polkit: polkit-gnome agent
- Keyring: GNOME Keyring (auto-unlocked via PAM)
- Snapshots: Snapper (hourly on /home, keeps 5h/7d/4w/6m)
- Btrfs scrub: weekly
- Logitech: wireless HID++ support (solaar)

### Compositor (Niri)
- Config format: KDL, written via `xdg.configFile` (not the niri home-manager module)
- XWayland enabled
- Portals: xdg-desktop-portal-gnome + gtk
- Prefer no CSD, rounded corners (10px), 16px gaps
- Focus ring: 2px monochrome

### Key Bindings (Niri)
| Bind | Action |
|---|---|
| Mod+T / Mod+Return | foot terminal |
| Mod+B | Firefox |
| Mod+E | Nautilus |
| Mod+D | Fuzzel launcher |
| Mod+Q | Close window |
| Mod+Shift+E | Quit niri |
| Super+Alt+L | Lock screen |
| Mod+F | Maximize column |
| Mod+Shift+F | Fullscreen |
| Mod+V | Toggle floating |
| Mod+O | Overview |
| Mod+R | Cycle column widths |
| Mod+Shift+C | Clipboard history |
| Mod+H/J/K/L | Vim-style focus |
| Mod+Ctrl+H/J/K/L | Vim-style move |
| Mod+1-9 | Workspaces |
| Mod+Ctrl+1-9 | Move to workspace |
| Print | Screenshot |
| Media keys | Volume, brightness, playback |

### Packages (shared)
- Browsers: Firefox, Chromium
- Apps: Obsidian, Signal Desktop, Zed Editor
- Terminal: foot, fish, starship
- Utilities: eza, bat, fd, ripgrep, fzf, unzip, btop, git, neovim
- File management: Nautilus + sushi (previewer) + GVFS + udiskie
- Media: zathura (PDF), imv (images), mpv (video/audio)
- Wayland: swaylock, swayidle, playerctl, pavucontrol, cliphist, polkit-gnome
- Tools: Claude Code (from unstable), restic, solaar

### Theme
- Monochrome throughout
- Font: Hack + Hack Nerd Font (for waybar icons)
- GTK: adw-gtk3-dark
- Icons: Papirus-Dark
- Cursor: Adwaita 24px
- Dark mode: dconf prefer-dark

### Session Variables
- `NIXOS_OZONE_WL=1` — Electron apps use Wayland
- `QT_QPA_PLATFORM=wayland` — Qt apps use Wayland
- `QT_WAYLAND_DISABLE_WINDOWDECORATION=1` — No Qt window decorations

### File Associations
- Web: Firefox
- PDF: Zathura
- Images: imv
- Video/Audio: mpv
- Folders: Nautilus
- Text: Zed Editor

## Flake Inputs
- `nixpkgs`: NixOS 25.11 (stable)
- `nixpkgs-unstable`: unstable channel (used for claude-code)
- `disko`: declarative disk partitioning
- `home-manager`: release-25.11

## Disk Layout (disko)
- Device passed via `specialArgs` (`disk` variable) — not hardcoded
- 512MB EFI System Partition (vfat, /boot)
- LUKS encrypted partition (password via `--disk-encryption-keys` during install)
- Btrfs with zstd compression + noatime on all subvolumes
- allowDiscards for SSD TRIM through LUKS

## Install (nixos-anywhere)
```bash
nix run github:nix-community/nixos-anywhere -- \
  --flake .#x270 \
  --disk-encryption-keys /tmp/disk-password /tmp/disk-password-local \
  root@<target-ip>
```

## Rebuild
```bash
# From GitHub (on target machine)
sudo nixos-rebuild switch --flake github:kfrost89/nixos#x270 --refresh

# From local copy
sudo nixos-rebuild switch --flake /tmp/nixos-config#x270
```

## TODO
- [ ] Pull hardware-configuration.nix from x270 and add to flake modules
- [ ] Add .gitignore (*.swp, result, .direnv/)
- [ ] Configure Bluetooth if needed
- [ ] Configure printing if needed
- [ ] Style mako notifications to match monochrome theme
- [ ] Enrich fish config (aliases, abbreviations)
- [ ] Set up restic backup targets
