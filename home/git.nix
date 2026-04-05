{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Phat Hiep Le";
      user.email = "phatlee1104@gmail.com";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };
}
