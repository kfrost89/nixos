{ ... }:

{
  programs.git = {
    enable = true;
    userName = "kfrost89";
    userEmail = "frost.kristian@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };
}
