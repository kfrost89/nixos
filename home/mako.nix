{
  services.mako = {
    enable = true;
    settings = {
      font = "Hack 11";
      background-color = "#1e1e1eee";
      text-color = "#d4d4d4";
      border-color = "#3a3a3a";
      progress-color = "over #505050";
      border-radius = 12;
      border-size = 2;
      padding = "14";
      margin = "12";
      width = 380;
      height = 120;
      default-timeout = 5000;
      group-by = "app-name";
      max-visible = 3;
      layer = "overlay";

      "[urgency=low]" = {
        border-color = "#3a3a3a";
        text-color = "#909090";
        default-timeout = 3000;
      };

      "[urgency=critical]" = {
        border-color = "#ffffff";
        text-color = "#ffffff";
        default-timeout = 0;
      };
    };
  };
}
