{
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza";
      ll = "eza -la";
      lt = "eza --tree";
      cat = "bat";
      update = "cd ~/nixos-config && nix flake update && git add flake.lock && git commit -m 'update packages' && git push && sudo nixos-rebuild switch --flake ~/nixos-config#x270";
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#x270";
      rebuild-github = "sudo nixos-rebuild switch --flake github:kfrost89/nixos#x270 --refresh";
      ".." = "cd ..";
      "..." = "cd ../..";
    };
    shellInit = ''
      set -g fish_greeting
    '';
  };
}
