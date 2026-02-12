{
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza";
      ll = "eza -la";
      lt = "eza --tree";
      cat = "bat";
      update = "cd ~/nixos-config && nix flake update && git add flake.lock && git commit -m 'update packages' && git push && sudo nixos-rebuild switch --flake ~/nixos-config#(hostname)";
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#(hostname)";
      rebuild-github = "sudo nixos-rebuild switch --flake github:kfrost89/nixos#(hostname) --refresh";
      ".." = "cd ..";
      "..." = "cd ../..";
    };
    shellInit = ''
      set -g fish_greeting
      if status is-interactive
        fastfetch
      end
    '';
  };
}
