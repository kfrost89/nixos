{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, disko, home-manager, firefox-addons, ... }:
  let
    unstable = import nixpkgs-unstable {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations.x270 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        disk = "/dev/nvme0n1";
        inherit unstable firefox-addons;
      };
      modules = [
        disko.nixosModules.disko
        home-manager.nixosModules.home-manager
        ./disko-config.nix
        ./hosts/x270/x270.nix
        ./hosts/x270/hardware-configuration.nix
        ./configuration.nix
        ./home.nix
      ];
    };

    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        disk = "/dev/nvme0n1";
        inherit unstable firefox-addons;
      };
      modules = [
        disko.nixosModules.disko
        home-manager.nixosModules.home-manager
        ./disko-config.nix
        ./hosts/desktop/desktop.nix
        ./hosts/desktop/hardware-configuration.nix
        ./configuration.nix
        ./home.nix
      ];
    };
  };
}
