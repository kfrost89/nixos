{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "Hack:size=16";
        prompt = "'> '";
        layer = "overlay";
        lines = 12;
        width = 50;
        horizontal-pad = 24;
        vertical-pad = 20;
        inner-pad = 12;
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
