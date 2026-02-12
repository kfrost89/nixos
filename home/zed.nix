{ ... }:

{
  xdg.configFile."zed/settings.json".text = builtins.toJSON {
    theme = "One Dark";
    ui_font_size = 15;
    buffer_font_family = "Hack";
    buffer_font_size = 14;
    tab_size = 2;
    format_on_save = "on";
    autosave = "on_focus_change";
    soft_wrap = "editor_width";
    relative_line_numbers = true;
    scrollbar.show = "never";
    indent_guides = {
      enabled = true;
      coloring = "fixed";
    };
    terminal = {
      font_family = "Hack";
      font_size = 13;
    };
    languages = {
      Astro = {
        tab_size = 2;
        format_on_save = "on";
      };
      Markdown = {
        soft_wrap = "editor_width";
        tab_size = 2;
      };
      JavaScript = {
        tab_size = 2;
        format_on_save = "on";
      };
      TypeScript = {
        tab_size = 2;
        format_on_save = "on";
      };
      Nix = {
        tab_size = 2;
        format_on_save = "on";
      };
    };
  };
}
