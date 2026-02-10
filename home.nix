{ pkgs, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";

  home-manager.users.frozt = {
    home.stateVersion = "25.11";

    home.pointerCursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
      gtk.enable = true;
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };

    gtk = {
      enable = true;
      theme.name = "adw-gtk3-dark";
      theme.package = pkgs.adw-gtk3;
      iconTheme.name = "Papirus-Dark";
      iconTheme.package = pkgs.papirus-icon-theme;
      cursorTheme.name = "Adwaita";
      cursorTheme.size = 24;
    };

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        # Browser
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";

        # PDF
        "application/pdf" = "org.pwmt.zathura.desktop";

        # Images
        "image/png" = "imv.desktop";
        "image/jpeg" = "imv.desktop";
        "image/gif" = "imv.desktop";
        "image/webp" = "imv.desktop";
        "image/svg+xml" = "imv.desktop";

        # Video
        "video/mp4" = "mpv.desktop";
        "video/mkv" = "mpv.desktop";
        "video/webm" = "mpv.desktop";
        "video/x-matroska" = "mpv.desktop";

        # Audio
        "audio/mpeg" = "mpv.desktop";
        "audio/flac" = "mpv.desktop";
        "audio/ogg" = "mpv.desktop";

        # File manager
        "inode/directory" = "org.gnome.Nautilus.desktop";

        # Text
        "text/plain" = "dev.zed.Zed.desktop";
      };
    };

    imports = [
      ./home/foot.nix
      ./home/fish.nix
      ./home/niri.nix
      ./home/waybar.nix
      ./home/mako.nix
      ./home/starship.nix
      ./home/impala.nix
      ./home/swaylock.nix
      ./home/swayidle.nix
    ];
  };
}
