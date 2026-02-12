{ ... }:

{
  xdg.configFile."espanso/config/default.yml".text = ''
    backend: Inject
    search_shortcut: ALT+SPACE
    keyboard_layout:
      rules: evdev
      model: pc105
      layout: dk
  '';

  xdg.configFile."espanso/match/base.yml".text = ''
    matches:
      - trigger: ":mail"
        replace: "your@email.com"

      - trigger: ":name"
        replace: "Kristian Frost"

      - trigger: ":today"
        replace: "{{date}}"
        vars:
          - name: date
            type: date
            params:
              format: "%m-%d-%Y"

      - trigger: ":time"
        replace: "{{time}}"
        vars:
          - name: time
            type: date
            params:
              format: "%H:%M"
  '';
}
