{
  programs.starship = {
    enable = true;
    settings = {
      format = "$directory$git_branch$git_status$nix_shell$cmd_duration$line_break$character";

      character = {
        success_symbol = "[∷](#a7c080)";
        error_symbol = "[∷](#e67e80)";
      };

      directory = {
        style = "bold #7fbbb3";
        truncation_length = 3;
        truncate_to_repo = true;
      };

      git_branch = {
        style = "#9da9a0";
        format = "[$symbol$branch]($style) ";
        symbol = "";
      };

      git_status = {
        style = "#9da9a0";
        format = "[$all_status$ahead_behind]($style) ";
        modified = "*";
        untracked = "?";
        staged = "+";
        deleted = "-";
        ahead = "↑";
        behind = "↓";
      };

      nix_shell = {
        style = "#83c092";
        format = "[$symbol]($style) ";
        symbol = "nix";
      };

      cmd_duration = {
        style = "#7a8478";
        format = "[$duration]($style) ";
        min_time = 2000;
      };

      aws.disabled = true;
      gcloud.disabled = true;
      azure.disabled = true;
      docker_context.disabled = true;
      nodejs.disabled = true;
      python.disabled = true;
      rust.disabled = true;
      golang.disabled = true;
      java.disabled = true;
      package.disabled = true;
    };
  };
}
