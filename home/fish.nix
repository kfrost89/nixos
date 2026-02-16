{ pkgs, ... }:

{
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza";
      ll = "eza -la";
      lt = "eza --tree";
      cat = "bat";
      update = "cd ~/nixos-config && nix --extra-experimental-features 'nix-command flakes' flake update && git add flake.lock && git diff --cached --quiet flake.lock && echo 'flake.lock already up to date, rebuilding...' || git commit -m 'update packages' && git push && sudo nixos-rebuild switch --flake ~/nixos-config#(hostname)";
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#(hostname)";
      rebuild-github = "sudo nixos-rebuild switch --flake github:kfrost89/nixos#(hostname) --refresh";
      preview-update = "cd ~/nixos-config && nix --extra-experimental-features 'nix-command flakes' flake update && nix --extra-experimental-features 'nix-command flakes' store diff-closures /run/current-system (nix --extra-experimental-features 'nix-command flakes' build ~/nixos-config#nixosConfigurations.(hostname).config.system.build.toplevel --print-out-paths --no-link)";
      ".." = "cd ..";
      "..." = "cd ../..";
    };
    shellInit = ''
      set -g fish_greeting
    '';
  };
}
