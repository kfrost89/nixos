{ ... }:

{
  xdg.configFile."espanso/config/default.yml".text = ''
    backend: Clipboard
    search_shortcut: ALT+SPACE
  '';

  xdg.configFile."espanso/match/base.yml".text = ''
    matches:
      - trigger: ":mail"
        replace: "your@email.com"

      - trigger: ":name"
        replace: "Kristian Frost"

      - trigger: ":date"
        replace: "{{date}}"
        vars:
          - name: date
            type: date
            params:
              format: "%d-%m-%Y"

      - trigger: ":time"
        replace: "{{time}}"
        vars:
          - name: time
            type: date
            params:
              format: "%H:%M"
  '';
}
