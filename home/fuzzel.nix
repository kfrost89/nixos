{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "Hack:size=14";
        prompt = "'  '";
        layer = "overlay";
        lines = 10;
        width = 45;
        horizontal-pad = 20;
        vertical-pad = 16;
        inner-pad = 10;
      };
      colors = {
        background = "272e33ff";
        text = "d3c6aaff";
        match = "a7c080ff";
        selection = "414b50ff";
        selection-text = "d3c6aaff";
        selection-match = "a7c080ff";
        border = "00000000";
      };
      border = {
        width = 0;
        radius = 14;
      };
    };
  };
}
