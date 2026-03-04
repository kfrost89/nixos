{ pkgs, ... }:

{
  programs.fish.plugins = [
    {
      name = "tide";
      src = pkgs.fishPlugins.tide.src;
    }
  ];

  programs.fish.interactiveShellInit = ''
    # Tide prompt — Everforest Dark
    set -g tide_left_prompt_items pwd git nix_shell cmd_duration newline character
    set -g tide_right_prompt_items

    # Prompt character
    set -g tide_character_icon "∷"
    set -g tide_character_vi_icon_default "∷"
    set -g tide_character_vi_icon_replace "∷"
    set -g tide_character_vi_icon_visual "∷"
    set -g tide_character_color a7c080
    set -g tide_character_color_failure e67e80

    # Directory
    set -g tide_pwd_color_dirs 7fbbb3
    set -g tide_pwd_color_anchors 7fbbb3
    set -g tide_pwd_color_truncated_dirs 7fbbb3

    # Git
    set -g tide_git_color_branch 9da9a0
    set -g tide_git_color_upstream 9da9a0
    set -g tide_git_color_stash 9da9a0
    set -g tide_git_color_dirty dbbc7f
    set -g tide_git_color_staged a7c080
    set -g tide_git_color_untracked 9da9a0
    set -g tide_git_color_conflicted e67e80
    set -g tide_git_color_operation e67e80

    # Nix shell
    set -g tide_nix_shell_color 83c092
    set -g tide_nix_shell_icon nix

    # Command duration
    set -g tide_cmd_duration_color 7a8478
    set -g tide_cmd_duration_threshold 2000

    # Layout
    set -g tide_prompt_add_newline_before false
  '';
}
