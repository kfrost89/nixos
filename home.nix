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
      font = {
        name = "Inter";
        size = 11;
      };
      theme.name = "adw-gtk3-dark";
      theme.package = pkgs.adw-gtk3;
      iconTheme.name = "Papirus-Dark";
      iconTheme.package = pkgs.papirus-icon-theme;
      cursorTheme.name = "Adwaita";
      cursorTheme.size = 24;
      gtk3.bookmarks = [
        "file:///mnt/storage Storage"
      ];
    };

    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "$HOME/Desktop";
      documents = "$HOME/Documents";
      download = "$HOME/Downloads";
      music = "$HOME/Music";
      pictures = "$HOME/Pictures";
      videos = "$HOME/Videos";
      templates = "$HOME/Templates";
      publicShare = "$HOME/Public";
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "$HOME/Pictures/Screenshots";
        XDG_BIN_DIR = "$HOME/Bin";
        XDG_DEV_DIR = "$HOME/Dev";
      };
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

    home.activation.createExtraDirs = ''
      mkdir -p "$HOME/Bin" "$HOME/Dev" "$HOME/Pictures/Screenshots"
    '';

    services.polkit-gnome.enable = true;

    imports = [
      ./home/foot.nix
      ./home/fish.nix
      ./home/niri.nix
      ./home/waybar.nix
      ./home/mako.nix
      ./home/starship.nix
      ./home/fastfetch.nix
      ./home/espanso.nix
      ./home/neovim.nix
      ./home/zed.nix
      ./home/swaylock.nix
      ./home/swayidle.nix
      ./home/fuzzel.nix
      ./home/firefox.nix
    ];
  };
}
