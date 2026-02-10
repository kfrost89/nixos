{
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza --icons";
      ll = "eza -la --icons";
      lt = "eza --tree --icons";
      cat = "bat";
      ".." = "cd ..";
      "..." = "cd ../..";
    };
    shellInit = ''
      set -g fish_greeting
    '';
  };
}
