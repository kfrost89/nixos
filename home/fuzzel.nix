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
        background = "1a1a1aee";
        text = "c0c0c0ff";
        match = "ffffffff";
        selection = "2a2a2aff";
        selection-text = "ffffffff";
        selection-match = "ffffffff";
        border = "4a4a4aff";
      };
      border = {
        width = 2;
        radius = 12;
      };
    };
  };
}
