{
  services.mako = {
    enable = true;
    settings = {
      font = "Hack 11";
      background-color = "#0e0e0eee";
      text-color = "#e0e0e0";
      border-color = "#2a2a2a";
      progress-color = "over #404040";
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
        border-color = "#2a2a2a";
        text-color = "#888888";
        default-timeout = 3000;
      };

      "[urgency=critical]" = {
        border-color = "#e0e0e0";
        text-color = "#ffffff";
        default-timeout = 0;
      };
    };
  };
}
