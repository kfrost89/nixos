{ ... }:

{
  xdg.configFile."fastfetch/config.jsonc".text = builtins.toJSON {
    logo = {
      type = "small";
      source = "nixos";
      color = {
        "1" = "white";
        "2" = "gray";
      };
    };
    display = {
      separator = "  ";
      color = "white";
    };
    modules = [
      { type = "title"; color = "white"; }
      { type = "separator"; string = "─"; }
      { type = "os"; key = "os"; }
      { type = "kernel"; key = "ker"; }
      { type = "uptime"; key = "up"; }
      { type = "packages"; key = "pkg"; }
      { type = "shell"; key = "sh"; }
      { type = "wm"; key = "wm"; }
      { type = "terminal"; key = "term"; }
      { type = "cpu"; key = "cpu"; }
      { type = "gpu"; key = "gpu"; }
      { type = "memory"; key = "mem"; }
      { type = "disk"; key = "disk"; }
      { type = "battery"; key = "bat"; }
      "break"
      { type = "colors"; paddingLeft = 2; }
    ];
  };
}
