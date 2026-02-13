# Neovim Shortcuts

Leader key: `Space`

Press `Space` and wait to see all available keybinds (which-key).

## General

| Key | Action |
|---|---|
| `Space w` | Save file |
| `Space q` | Quit |
| `Space e` | Open file explorer (netrw) |
| `Esc` | Clear search highlight |

## Navigation

| Key | Action |
|---|---|
| `Ctrl+d` | Half page down (centered) |
| `Ctrl+u` | Half page up (centered) |

## Editing

| Key | Mode | Action |
|---|---|---|
| `J` | Visual | Move selected lines down |
| `K` | Visual | Move selected lines up |
| `gc` | Normal/Visual | Toggle line comment |
| `gbc` | Normal | Toggle block comment |

## Telescope (fuzzy finder)

| Key | Action |
|---|---|
| `Space ff` | Find files |
| `Space fg` | Live grep |
| `Space fb` | Open buffers |

## LSP

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gr` | Find references |
| `K` | Hover documentation |
| `Space rn` | Rename symbol |
| `Space ca` | Code action |
| `Space d` | Show diagnostics |

## Autocomplete

| Key | Action |
|---|---|
| `Ctrl+Space` | Trigger completion |
| `Tab` | Next suggestion |
| `Shift+Tab` | Previous suggestion |
| `Enter` | Confirm selection |

## Formatting

Files are formatted automatically on save with prettier (js, ts, html, css, json, yaml, markdown, astro).

## Git

| Key | Action |
|---|---|
| `Space gg` | Open lazygit (floating inside neovim) |
