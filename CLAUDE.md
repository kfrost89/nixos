# NixOS Configuration

## Rules

- **Always use Home Manager** for app configs — never write dotfiles manually
- Config files go in `home/` as separate `.nix` modules, imported in `home.nix`
- Use `xdg.configFile` for apps without a Home Manager module (e.g. niri, espanso)
- Use `programs.*` or `services.*` when Home Manager has native support (e.g. foot, fish, starship)

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
│   ├── foot.nix              # Terminal emulator (Hack font, muted color palette)
│   ├── fish.nix              # Fish shell (aliases: rebuild, update, rebuild-github)
│   ├── starship.nix          # Shell prompt (minimal, ∷ symbol)
│   ├── niri.nix              # Niri compositor config (KDL via xdg.configFile)
│   ├── waybar.nix            # Status bar (dynamic island: cpu, mem, disk, mpris, idle)
│   ├── mako.nix              # Notification daemon
│   ├── fuzzel.nix            # App launcher
│   ├── espanso.nix           # Text expander (Wayland)
│   ├── swaylock.nix          # Lock screen
│   ├── swayidle.nix          # Idle management (lock 5min, monitors off 10min)
├── hosts/
│   ├── x270/
│   │   ├── x270.nix          # ThinkPad X270: Intel GPU, TLP, thermald, trackpoint
│   │   └── hardware-configuration.nix
│   └── desktop/
│       ├── desktop.nix       # Desktop: NVIDIA proprietary, Steam, gamemode
│       └── hardware-configuration.nix
```

## Hosts

### x270 (ThinkPad X270)
- Intel GPU with `hardware.graphics`
- Power management: TLP + thermald
- WiFi: iwd + impala (laptop-only)
- Brightness: brightnessctl (laptop-only)
- TrackPoint with scroll emulation
- fstrim for SSD

### desktop (NVIDIA)
- NVIDIA proprietary driver (modesetting)
- Steam with gamescope session
- Gamemode enabled

## Aliases (fish)

- `rebuild` — rebuild from local clone (auto-detects hostname)
- `update` — update flake + rebuild + push
- `rebuild-github` — rebuild from GitHub repo

## Theme

- Background: `#363636` (niri), `#1e1e1e` (foot)
- Dynamic island: `rgba(0,0,0,0.85)` (waybar)
- Text: `#e0e0e0` primary, `#888888` secondary
- Terminal colors: muted desaturated palette (not pure monochrome)
- Font: Hack
- GTK: adw-gtk3-dark, Papirus-Dark icons, Adwaita cursor 24px
- No animations

## Flake Inputs
- `nixpkgs`: NixOS 25.11 (stable)
- `nixpkgs-unstable`: unstable channel (for claude-code)
- `disko`: declarative disk partitioning
- `home-manager`: release-25.11

## Install (nixos-anywhere)
```bash
echo "password" > /tmp/disk-password
nix run github:nix-community/nixos-anywhere -- \
  --flake ~/nixos-config#<host> \
  --disk-encryption-keys /tmp/disk-password /tmp/disk-password \
  root@<ip>
rm /tmp/disk-password
```

After install, generate and pull hardware config:
```bash
ssh root@<ip> "nixos-generate-config --no-filesystems --dir /tmp/hw"
scp root@<ip>:/tmp/hw/hardware-configuration.nix ~/nixos-config/hosts/<host>/
```
