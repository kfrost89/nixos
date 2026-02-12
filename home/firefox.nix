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
        "font.size.variable.x-western" = 16;
        "font.size.monospace.x-western" = 14;
        "font.default.x-western" = "sans-serif";

        # Better rendering
        "gfx.webrender.all" = true;
        "gfx.text.subpixel-position.force-enabled" = true;

        # Spellcheck (Danish + English)
        "spellchecker.dictionary" = "da,en-US";
        "layout.spellcheckDefault" = 1;
      };
    };
  };
}
