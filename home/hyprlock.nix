{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        grace = 3;
      };
      background = [{
        monitor = "";
        color = "rgb(272e33)";
      }];
      input-field = [{
        monitor = "";
        size = "250, 50";
        outline_thickness = 3;
        outer_color = "rgb(414b50)";
        inner_color = "rgb(272e33)";
        font_color = "rgb(d3c6aa)";
        check_color = "rgb(7fbbb3)";
        fail_color = "rgb(e67e80)";
        fade_on_empty = false;
        placeholder_text = "";
        fail_text = "";
        font_family = "Hack";
        rounding = 8;
      }];
    };
  };
}
