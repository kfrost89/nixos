{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "Hack:size=12";
        prompt = "'> '";
        layer = "overlay";
        lines = 8;
        width = 35;
        horizontal-pad = 16;
        vertical-pad = 12;
        inner-pad = 8;
      };
      colors = {
        background = "000000d9";
        text = "e0e0e0ff";
        match = "ffffffff";
        selection = "2a2a2aff";
        selection-text = "ffffffff";
        selection-match = "ffffffff";
        border = "00000000";
      };
      border = {
        width = 0;
        radius = 14;
      };
    };
  };
}
