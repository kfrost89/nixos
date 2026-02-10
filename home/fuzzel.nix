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
        background = "1e1e1eee";
        text = "d4d4d4ff";
        match = "ffffffff";
        selection = "333333ff";
        selection-text = "ffffffff";
        selection-match = "ffffffff";
        border = "505050ff";
      };
      border = {
        width = 2;
        radius = 12;
      };
    };
  };
}
