# NixOS Configuration

## Rules

- **Always use Home Manager** for app configs — never write dotfiles manually
- Config files go in `home/` as separate `.nix` modules, imported in `home.nix`
- Use `xdg.configFile` for apps without a Home Manager module (e.g. niri, espanso)
- Use `programs.*` or `services.*` when Home Manager has native support (e.g. foot, fish, starship)
- **Try before install**: Use `nix shell nixpkgs#<package>` to test apps temporarily instead of adding them to configuration.nix

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
│   ├── neovim.nix            # Neovim (LSP, treesitter, telescope, oil, conform)
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
- Motherboard: ASUS Z690-P
- NVIDIA proprietary driver (modesetting, closed source)
- HDMI audio routed to monitor speakers (priority via WirePlumber)
- Steam with gamescope session
- Gamemode enabled
- Secondary storage: `/mnt/storage` (Btrfs, zstd compression)
- Webcam: Logitech Brio (1080p via USB 2.0, 4K requires USB 3.0)
- Espanso: runs with `cap_dac_override` capability wrapper (Wayland requirement)

## Aliases (fish)

- `rebuild` — rebuild from local clone (auto-detects hostname)
- `update` — update flake + rebuild + push
- `rebuild-github` — rebuild from GitHub repo

## Disk Layout (disko)

- GPT partition table
- 512M ESP (`/boot`)
- LUKS-encrypted Btrfs with subvolumes: `@` (`/`), `@home`, `@nix`, `@log`, `@snapshots`
- Compression: zstd, noatime on all subvolumes
- Snapshots: snapper (hourly, 5h/7d/4w/6m retention)

## Niri Keybinds (Mod = Super)

| Key | Action |
|---|---|
| `Mod+T` / `Mod+Return` | Terminal |
| `Mod+B` | Firefox |
| `Mod+D` | Fuzzel (launcher) |
| `Mod+E` | Nautilus |
| `Mod+S` | Signal |
| `Mod+N` | Obsidian |
| `Mod+Q` | Close window |
| `Mod+F` | Maximize column |
| `Mod+Shift+F` | Fullscreen |
| `Mod+V` | Toggle floating |
| `Mod+O` | Overview |
| `Mod+H/J/K/L` | Focus (vim-style) |
| `Mod+Ctrl+H/J/K/L` | Move window |
| `Mod+1-9` | Switch workspace |
| `Mod+Ctrl+1-9` | Move to workspace |
| `Mod+Scroll` | Scroll workspaces |
| `Super+Alt+L` | Lock screen |
| `Print` | Screenshot |

## Theme

- Background: `#363636` (niri), `#1e1e1e` (foot)
- Dynamic island: `rgba(0,0,0,0.85)` (waybar)
- Text: `#e0e0e0` primary, `#888888` secondary
- Terminal colors: muted desaturated palette (not pure monochrome)
- Font: Hack
- GTK: adw-gtk3-dark, Papirus-Dark icons, Adwaita cursor 24px
- No animations

## Neovim

- Leader: `Space`
- LSP: astro, typescript, html, css, json, markdown (marksman), nix (nil)
- Plugins: telescope, treesitter, nvim-cmp, oil, conform (prettier), lazygit, gitsigns, which-key, comment, autopairs, render-markdown
- Format on save via prettier
- Key shortcuts in `neovim-shortcuts.md`

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
