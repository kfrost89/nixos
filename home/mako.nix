{
  services.mako = {
    enable = true;
    settings = {
      font = "Hack 11";
      background-color = "#272e33ee";
      text-color = "#d3c6aa";
      border-color = "#414b50";
      progress-color = "over #2e383c";
      border-radius = 12;
      border-size = 2;
      padding = "14";
      margin = "12";
      width = 380;
      height = 120;
      default-timeout = 5000;
      group-by = "app-name";
      max-visible = 3;
      anchor = "top-center";
      layer = "overlay";

      "urgency=low" = {
        border-color = "#414b50";
        text-color = "#9da9a0";
        default-timeout = 3000;
      };

      "urgency=critical" = {
        border-color = "#e67e80";
        text-color = "#d3c6aa";
        default-timeout = 0;
      };

      "mode=do-not-disturb" = {
        invisible = 1;
      };
    };
  };
}
