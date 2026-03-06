{ pkgs, firefox-addons, ... }:

{
  programs.librewolf = {
    enable = true;
    languagePacks = [ "da" "en-US" ];
    profiles.default = {
      isDefault = true;
      extensions.packages = with firefox-addons.packages.x86_64-linux; [
        bitwarden
        vimium
      ];
      settings = {
        # Fonts — macOS style
        "font.name.serif.x-western" = "Noto Serif";
        "font.name.sans-serif.x-western" = "IBM Plex Sans";
        "font.name.monospace.x-western" = "Hack";
        "font.size.variable.x-western" = 17;
        "font.size.monospace.x-western" = 14;
        "font.default.x-western" = "sans-serif";

        # Better rendering
        "gfx.webrender.all" = true;
        "gfx.text.subpixel-position.force-enabled" = true;

        # Spellcheck (Danish + English)
        "spellchecker.dictionary" = "da,en-US";
        "layout.spellcheckDefault" = 2;

        # Restore previous session
        "browser.startup.page" = 3;

        # Compact UI
        "browser.compactmode.show" = true;
        "browser.uidensity" = 1;
        "full-screen-api.warning.timeout" = 0;

        # Wayland native file picker
        "widget.use-xdg-desktop-portal.file-picker" = 1;

        # Hardware video decoding
        "media.ffmpeg.vaapi.enabled" = true;

        # Disable middle-click paste
        "middlemouse.paste" = false;

        # New tabs open next to current
        "browser.tabs.insertAfterCurrent" = true;

        # Disable resistFingerprinting (fixes timezone, theme, canvas)
        "privacy.resistFingerprinting" = false;

        # Keep cookies and sessions across restarts
        "privacy.clearOnShutdown.cookies" = false;
        "privacy.clearOnShutdown.offlineApps" = false;
        "network.cookie.lifetimePolicy" = 0;

        # Smooth scrolling
        "general.smoothScroll" = true;
        "mousewheel.default.delta_multiplier_y" = 200;
      };
    };
  };
}
