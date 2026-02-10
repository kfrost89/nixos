{
  services.mako = {
    enable = true;
    settings = {
      font = "Hack 11";
      background-color = "#1a1a1aee";
      text-color = "#c0c0c0";
      border-color = "#2a2a2a";
      progress-color = "over #4a4a4a";
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
        border-color = "#ffffff";
        text-color = "#ffffff";
        default-timeout = 0;
      };
    };
  };
}
