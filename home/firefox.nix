{ ... }:

{
  programs.firefox = {
    enable = true;
    profiles.default = {
      isDefault = true;
      settings = {
        # Fonts — macOS style
        "font.name.serif.x-western" = "Noto Serif";
        "font.name.sans-serif.x-western" = "Inter";
        "font.name.monospace.x-western" = "Hack";
        "font.size.variable.x-western" = 18;
        "font.size.monospace.x-western" = 15;
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

        # Privacy
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "extensions.pocket.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "app.shield.optoutstudies.enabled" = false;

        # HTTPS-only
        "dom.security.https_only_mode" = true;

        # Disable autofill
        "signon.rememberSignons" = false;
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.creditCards.enabled" = false;

        # Smooth scrolling
        "general.smoothScroll" = true;
        "mousewheel.default.delta_multiplier_y" = 200;
      };
    };
  };
}
