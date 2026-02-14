{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "kfrost89";
      user.email = "frost.kristian@gmail.com";
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };
}
