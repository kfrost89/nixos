{ pkgs, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";

  home-manager.users.frozt = {
    home.stateVersion = "24.11";

    home.pointerCursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
      gtk.enable = true;
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
